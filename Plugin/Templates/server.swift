//-{% for service in file.services %}

/// Type for errors thrown from generated server code.
{{ access }} enum {{ .|servererror:file,service }} : Error {
  case endOfStream
}

/// To build a server, implement a class that conforms to this protocol.
{{ access }} protocol {{ .|provider:file,service }} {
  //-{% for method in service.methods %}
  //-{% if method|methodIsUnary %}
  func {{ method|methodDescriptorName|lowercase }}(request : {{ method|input }}, session : {{ .|session:file,service,method }}) throws -> {{ method|output }}
  //-{% endif %}
  //-{% if method|methodIsServerStreaming %}
  func {{ method|methodDescriptorName|lowercase }}(request : {{ method|input }}, session : {{ .|session:file,service,method }}) throws
  //-{% endif %}
  //-{% if method|methodIsClientStreaming %}
  func {{ method|methodDescriptorName|lowercase }}(session : {{ .|session:file,service,method }}) throws
  //-{% endif %}
  //-{% if method|methodIsBidiStreaming %}
  func {{ method|methodDescriptorName|lowercase }}(session : {{ .|session:file,service,method }}) throws
  //-{% endif %}
  //-{% endfor %}
}

/// Common properties available in each service session.
{{ access }} protocol {{ .|service:file,service }}Session {
  var requestMetadata : Metadata { get }

  var statusCode : StatusCode { get }
  var statusMessage : String { get }
  var initialMetadata : Metadata { get }
  var trailingMetadata : Metadata { get }
}

fileprivate class {{ .|service:file,service }}SessionImpl: {{ .|service:file,service }}Session {
  var handler : Handler
  var requestMetadata : Metadata { return handler.requestMetadata }

  var statusCode : StatusCode = .ok
  var statusMessage : String = "OK"
  var initialMetadata : Metadata = Metadata()
  var trailingMetadata : Metadata = Metadata()

  init(handler:Handler) {
    self.handler = handler
  }
}

//-{% if generateTestStubs %}
class {{ .|service:file,service }}SessionTestStub: {{ .|service:file,service }}Session {
  var requestMetadata = Metadata()

  var statusCode = StatusCode.ok
  var statusMessage = "OK"
  var initialMetadata = Metadata()
  var trailingMetadata = Metadata()
}
//-{% endif %}

//-{% for method in service.methods %}
//-{% if method|methodIsUnary %}
//-{% include "server-session-unary.swift" %}
//-{% endif %}
//-{% if method|methodIsServerStreaming %}
//-{% include "server-session-serverstreaming.swift" %}
//-{% endif %}
//-{% if method|methodIsClientStreaming %}
//-{% include "server-session-clientstreaming.swift" %}
//-{% endif %}
//-{% if method|methodIsBidiStreaming %}
//-{% include "server-session-bidistreaming.swift" %}
//-{% endif %}
//-{% endfor %}

/// Main server for generated service
{{ access }} final class {{ .|server:file,service }} {
  private var address: String
  private var server: Server
  private var provider: {{ .|provider:file,service }}?

  /// Create a server that accepts insecure connections.
  {{ access }} init(address:String,
              provider:{{ .|provider:file,service }}) {
    gRPC.initialize()
    self.address = address
    self.provider = provider
    self.server = Server(address:address)
  }

  /// Create a server that accepts secure connections.
  {{ access }} init?(address:String,
               certificateURL:URL,
               keyURL:URL,
               provider:{{ .|provider:file,service }}) {
    gRPC.initialize()
    self.address = address
    self.provider = provider
    guard
      let certificate = try? String(contentsOf: certificateURL, encoding: .utf8),
      let key = try? String(contentsOf: keyURL, encoding: .utf8)
      else {
        return nil
    }
    self.server = Server(address:address, key:key, certs:certificate)
  }

  /// Start the server.
  {{ access }} func start(queue:DispatchQueue = DispatchQueue.global()) {
    guard let provider = self.provider else {
      fatalError() // the server requires a provider
    }
    server.run {(handler) in
      let unwrappedHost = handler.host ?? "(nil)"
      let unwrappedMethod = handler.method ?? "(nil)"
      let unwrappedCaller = handler.caller ?? "(nil)"
      print("Server received request to " + unwrappedHost
        + " calling " + unwrappedMethod
        + " from " + unwrappedCaller
        + " with " + handler.requestMetadata.description)

      do {
        switch unwrappedMethod {
        //-{% for method in service.methods %}
        case "{{ .|path:file,service,method }}":
          try {{ .|session:file,service,method }}Impl(handler:handler, provider:provider).run(queue:queue)
        //-{% endfor %}
        default:
          // handle unknown requests
          try handler.receiveMessage(initialMetadata:Metadata()) {(requestData) in
            try handler.sendResponse(statusCode:.unimplemented,
                                     statusMessage:"unknown method " + unwrappedMethod,
                                     trailingMetadata:Metadata())
          }
        }
      } catch (let error) {
        print("Server error: \(error)")
      }
    }
  }
}
//-{% endfor %}
