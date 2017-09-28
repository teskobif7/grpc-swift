/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: echo.proto
 *
 */

/*
 * Copyright 2017, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import Foundation
import Dispatch
import gRPC
import SwiftProtobuf

/// Type for errors thrown from generated server code.
internal enum Echo_EchoServerError : Error {
  case endOfStream
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Echo_EchoProvider {
  func get(request : Echo_EchoRequest, session : Echo_EchoGetSession) throws -> Echo_EchoResponse
  func expand(request : Echo_EchoRequest, session : Echo_EchoExpandSession) throws
  func collect(session : Echo_EchoCollectSession) throws
  func update(session : Echo_EchoUpdateSession) throws
}

/// Common properties available in each service session.
internal class Echo_EchoSession {
  fileprivate var handler : gRPC.Handler
  internal var requestMetadata : Metadata { return handler.requestMetadata }

  internal var statusCode : Int = 0
  internal var statusMessage : String = "OK"
  internal var initialMetadata : Metadata = Metadata()
  internal var trailingMetadata : Metadata = Metadata()

  fileprivate init(handler:gRPC.Handler) {
    self.handler = handler
  }
}

// Get (Unary)
internal class Echo_EchoGetSession : Echo_EchoSession {
  private var provider : Echo_EchoProvider

  /// Create a session.
  fileprivate init(handler:gRPC.Handler, provider: Echo_EchoProvider) {
    self.provider = provider
    super.init(handler:handler)
  }

  /// Run the session. Internal.
  fileprivate func run(queue:DispatchQueue) throws {
    try handler.receiveMessage(initialMetadata:initialMetadata) {(requestData) in
      if let requestData = requestData {
        let requestMessage = try Echo_EchoRequest(serializedData:requestData)
        let replyMessage = try self.provider.get(request:requestMessage, session: self)
        try self.handler.sendResponse(message:replyMessage.serializedData(),
                                      statusCode:self.statusCode,
                                      statusMessage:self.statusMessage,
                                      trailingMetadata:self.trailingMetadata)
      }
    }
  }
}

// Expand (Server Streaming)
internal class Echo_EchoExpandSession : Echo_EchoSession {
  private var provider : Echo_EchoProvider

  /// Create a session.
  fileprivate init(handler:gRPC.Handler, provider: Echo_EchoProvider) {
    self.provider = provider
    super.init(handler:handler)
  }

  /// Send a message. Nonblocking.
  internal func send(_ response: Echo_EchoResponse) throws {
    try handler.sendResponse(message:response.serializedData()) {}
  }

  /// Run the session. Internal.
  fileprivate func run(queue:DispatchQueue) throws {
    try self.handler.receiveMessage(initialMetadata:initialMetadata) {(requestData) in
      if let requestData = requestData {
        do {
          let requestMessage = try Echo_EchoRequest(serializedData:requestData)
          // to keep providers from blocking the server thread,
          // we dispatch them to another queue.
          queue.async {
            do {
              try self.provider.expand(request:requestMessage, session: self)
              try self.handler.sendStatus(statusCode:self.statusCode,
                                          statusMessage:self.statusMessage,
                                          trailingMetadata:self.trailingMetadata,
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

// Collect (Client Streaming)
internal class Echo_EchoCollectSession : Echo_EchoSession {
  private var provider : Echo_EchoProvider

  /// Create a session.
  fileprivate init(handler:gRPC.Handler, provider: Echo_EchoProvider) {
    self.provider = provider
    super.init(handler:handler)
  }

  /// Receive a message. Blocks until a message is received or the client closes the connection.
  internal func receive() throws -> Echo_EchoRequest {
    let sem = DispatchSemaphore(value: 0)
    var requestMessage : Echo_EchoRequest?
    try self.handler.receiveMessage() {(requestData) in
      if let requestData = requestData {
        requestMessage = try? Echo_EchoRequest(serializedData:requestData)
      }
      sem.signal()
    }
    _ = sem.wait(timeout: DispatchTime.distantFuture)
    if requestMessage == nil {
      throw Echo_EchoServerError.endOfStream
    }
    return requestMessage!
  }

  /// Send a response and close the connection.
  internal func sendAndClose(_ response: Echo_EchoResponse) throws {
    try self.handler.sendResponse(message:response.serializedData(),
                                  statusCode:self.statusCode,
                                  statusMessage:self.statusMessage,
                                  trailingMetadata:self.trailingMetadata)
  }

  /// Run the session. Internal.
  fileprivate func run(queue:DispatchQueue) throws {
    try self.handler.sendMetadata(initialMetadata:initialMetadata) {
      queue.async {
        do {
          try self.provider.collect(session:self)
        } catch (let error) {
          print("error \(error)")
        }
      }
    }
  }
}

// Update (Bidirectional Streaming)
internal class Echo_EchoUpdateSession : Echo_EchoSession {
  private var provider : Echo_EchoProvider

  /// Create a session.
  fileprivate init(handler:gRPC.Handler, provider: Echo_EchoProvider) {
    self.provider = provider
    super.init(handler:handler)
  }

  /// Receive a message. Blocks until a message is received or the client closes the connection.
  internal func receive() throws -> Echo_EchoRequest {
    let sem = DispatchSemaphore(value: 0)
    var requestMessage : Echo_EchoRequest?
    try self.handler.receiveMessage() {(requestData) in
      if let requestData = requestData {
        do {
          requestMessage = try Echo_EchoRequest(serializedData:requestData)
        } catch (let error) {
          print("error \(error)")
        }
      }
      sem.signal()
    }
    _ = sem.wait(timeout: DispatchTime.distantFuture)
    if let requestMessage = requestMessage {
      return requestMessage
    } else {
      throw Echo_EchoServerError.endOfStream
    }
  }

  /// Send a message. Nonblocking.
  internal func send(_ response: Echo_EchoResponse) throws {
    try handler.sendResponse(message:response.serializedData()) {}
  }

  /// Close a connection. Blocks until the connection is closed.
  internal func close() throws {
    let sem = DispatchSemaphore(value: 0)
    try self.handler.sendStatus(statusCode:self.statusCode,
                                statusMessage:self.statusMessage,
                                trailingMetadata:self.trailingMetadata) {
                                  sem.signal()
    }
    _ = sem.wait(timeout: DispatchTime.distantFuture)
  }

  /// Run the session. Internal.
  fileprivate func run(queue:DispatchQueue) throws {
    try self.handler.sendMetadata(initialMetadata:initialMetadata) {
      queue.async {
        do {
          try self.provider.update(session:self)
        } catch (let error) {
          print("error \(error)")
        }
      }
    }
  }
}


/// Main server for generated service
internal class Echo_EchoServer {
  private var address: String
  private var server: gRPC.Server
  private var provider: Echo_EchoProvider?

  /// Create a server that accepts insecure connections.
  internal init(address:String,
              provider:Echo_EchoProvider) {
    gRPC.initialize()
    self.address = address
    self.provider = provider
    self.server = gRPC.Server(address:address)
  }

  /// Create a server that accepts secure connections.
  internal init?(address:String,
               certificateURL:URL,
               keyURL:URL,
               provider:Echo_EchoProvider) {
    gRPC.initialize()
    self.address = address
    self.provider = provider
    guard
      let certificate = try? String(contentsOf: certificateURL, encoding: .utf8),
      let key = try? String(contentsOf: keyURL, encoding: .utf8)
      else {
        return nil
    }
    self.server = gRPC.Server(address:address, key:key, certs:certificate)
  }

  /// Start the server.
  internal func start(queue:DispatchQueue = DispatchQueue.global()) {
    guard let provider = self.provider else {
      assert(false) // the server requires a provider
    }
    server.run {(handler) in
      print("Server received request to " + handler.host
        + " calling " + handler.method
        + " from " + handler.caller
        + " with " + String(describing:handler.requestMetadata) )

      do {
        switch handler.method {
        case "/echo.Echo/Get":
          try Echo_EchoGetSession(handler:handler, provider:provider).run(queue:queue)
        case "/echo.Echo/Expand":
          try Echo_EchoExpandSession(handler:handler, provider:provider).run(queue:queue)
        case "/echo.Echo/Collect":
          try Echo_EchoCollectSession(handler:handler, provider:provider).run(queue:queue)
        case "/echo.Echo/Update":
          try Echo_EchoUpdateSession(handler:handler, provider:provider).run(queue:queue)
        default:
          break // handle unknown requests
        }
      } catch (let error) {
        print("Server error: \(error)")
      }
    }
  }
}
