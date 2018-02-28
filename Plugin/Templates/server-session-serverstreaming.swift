// {{ method|methodDescriptorName }} (Server Streaming)
{{ access }} protocol {{ .|session:file,service,method }} : {{ .|service:file,service }}Session {
  /// Send a message. Nonblocking.
  func send(_ response: {{ method|output }}, completion: ((Bool)->())?) throws
}

fileprivate final class {{ .|session:file,service,method }}Impl : {{ .|service:file,service }}SessionImpl, {{ .|session:file,service,method }} {
  private var provider : {{ .|provider:file,service }}

  /// Create a session.
  init(handler:Handler, provider: {{ .|provider:file,service }}) {
    self.provider = provider
    super.init(handler:handler)
  }

  func send(_ response: {{ method|output }}, completion: ((Bool)->())?) throws {
    try handler.sendResponse(message:response.serializedData(), completion: completion)
  }

  /// Run the session. Internal.
  func run(queue:DispatchQueue) throws {
    try self.handler.receiveMessage(initialMetadata:initialMetadata) {(requestData) in
      if let requestData = requestData {
        do {
          let requestMessage = try {{ method|input }}(serializedData:requestData)
          // to keep providers from blocking the server thread,
          // we dispatch them to another queue.
          queue.async {
            do {
              try self.provider.{{ method|methodDescriptorName|lowercase }}(request:requestMessage, session: self)
              try self.handler.sendStatus(statusCode:self.statusCode,
                                          statusMessage:self.statusMessage,
                                          trailingMetadata:self.trailingMetadata,
                                          completion:nil)
            } catch (let error) {
              print("error: \(error)")
            }
          }
        } catch (let error) {
          print("error: \(error)")
        }
      }
    }
  }
}

//-{% if generateTestStubs %}
/// Simple fake implementation of {{ .|session:file,service,method }} that returns a previously-defined set of results
/// and stores sent values for later verification.
class {{ .|session:file,service,method }}TestStub : {{ .|service:file,service }}SessionTestStub, {{ .|session:file,service,method }} {
  var outputs: [{{ method|output }}] = []

  func send(_ response: {{ method|output }}, completion: @escaping ()->()) throws {
    outputs.append(response)
  }

  func close() throws { }
}
//-{% endif %}
