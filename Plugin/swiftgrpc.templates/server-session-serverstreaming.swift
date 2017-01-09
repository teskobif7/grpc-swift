// {{ method.name }} (Server Streaming)
public class {{ .|session:protoFile,service,method }} {
  private var handler : gRPC.Handler
  private var provider : {{ .|provider:protoFile,service }}

  /// Create a session.
  fileprivate init(handler:gRPC.Handler, provider: {{ .|provider:protoFile,service }}) {
    self.handler = handler
    self.provider = provider
  }

  /// Send a message. Nonblocking.
  public func Send(_ response: {{ method|output }}) throws {
    try handler.sendResponse(message:response.serializeProtobuf()) {}
  }

  /// Run the session. Internal.
  fileprivate func run(queue:DispatchQueue) throws {
    try self.handler.receiveMessage(initialMetadata:Metadata()) {(requestData) in
      if let requestData = requestData {
        do {
          let requestMessage = try {{ method|input }}(protobuf:requestData)
          // to keep providers from blocking the server thread,
          // we dispatch them to another queue.
          queue.async {
            do {
              try self.provider.{{ method.name|lowercase }}(request:requestMessage, session: self)
              try self.handler.sendStatus(statusCode:0,
                                          statusMessage:"OK",
                                          trailingMetadata:Metadata(),
                                          completion:{})
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
