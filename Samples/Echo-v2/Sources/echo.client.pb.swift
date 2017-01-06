/*
 *
 * Copyright 2016, Google Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 *     * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following disclaimer
 * in the documentation and/or other materials provided with the
 * distribution.
 *     * Neither the name of Google Inc. nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

// all code that follows is to-be-generated

import Foundation
import gRPC

public enum Echo_EchoClientError : Error {
  case endOfStream
  case invalidMessageReceived
  case error(c: CallResult)
}

//
// Unary GET
//
public class Echo_EchoGetCall {
  var call : Call

  fileprivate init(_ channel: Channel) {
    self.call = channel.makeCall("/echo.Echo/Get")
  }

  fileprivate func run(request: Echo_EchoRequest,
                       metadata: Metadata) throws -> Echo_EchoResponse {
    let done = NSCondition()
    var callResult : CallResult!
    var responseMessage : Echo_EchoResponse?
    let requestMessageData = try! request.serializeProtobuf()
    try! call.perform(message: requestMessageData,
                      metadata: metadata)
    {(_callResult) in
      callResult = _callResult
      if let messageData = callResult.resultData {
        responseMessage = try? Echo_EchoResponse(protobuf:messageData)
      }
      done.lock()
      done.signal()
      done.unlock()
    }
    done.lock()
    done.wait()
    done.unlock()
    if let responseMessage = responseMessage {
      return responseMessage
    } else {
      throw Echo_EchoClientError.error(c: callResult)
    }
  }
}

//
// Server-streaming EXPAND
//
public class Echo_EchoExpandCall {
  var call : Call

  fileprivate init(_ channel: Channel) {
    self.call = channel.makeCall("/echo.Echo/Expand")
  }

  // Call this once with the message to send.
  fileprivate func run(request: Echo_EchoRequest, metadata: Metadata) throws -> Echo_EchoExpandCall {
    let requestMessageData = try! request.serializeProtobuf()
    try! call.startServerStreaming(message: requestMessageData,
                                   metadata: metadata,
                                   completion:{(CallResult) in })
    return self
  }

  // Call this to wait for a result. Blocks.
  public func Receive() throws -> Echo_EchoResponse {
    var returnError : Echo_EchoClientError?
    var returnMessage : Echo_EchoResponse!
    let done = NSCondition()
    do {
      try call.receiveMessage() {(data) in
        if let data = data {
          returnMessage = try? Echo_EchoResponse(protobuf:data)
          if returnMessage == nil {
            returnError = Echo_EchoClientError.invalidMessageReceived
          }
        } else {
          returnError = Echo_EchoClientError.endOfStream
        }
        done.lock()
        done.signal()
        done.unlock()
      }
      done.lock()
      done.wait()
      done.unlock()
    }
    if let returnError = returnError {
      throw returnError
    }
    return returnMessage
  }
}

//
// Client-streaming COLLECT
//
public class Echo_EchoCollectCall {
  var call : Call

  fileprivate init(_ channel: Channel) {
    self.call = channel.makeCall("/echo.Echo/Collect")
  }

  // Call this to start a call.
  fileprivate func run(metadata:Metadata) throws -> Echo_EchoCollectCall {
    try self.call.start(metadata: metadata, completion:{})
    return self
  }

  // Call this to send each message in the request stream.
  public func Send(_ message: Echo_EchoRequest) {
    let messageData = try! message.serializeProtobuf()
    _ = call.sendMessage(data:messageData)
  }

  // Call this to close the connection and wait for a response. Blocks.
  public func CloseAndReceive() throws -> Echo_EchoResponse {
    var returnError : Echo_EchoClientError?
    var returnMessage : Echo_EchoResponse!
    let done = NSCondition()

    do {
      try self.receiveMessage() {(responseMessage) in
        if let responseMessage = responseMessage {
          returnMessage = responseMessage
        } else {
          returnError = Echo_EchoClientError.invalidMessageReceived
        }
        done.lock()
        done.signal()
        done.unlock()
      }
      try call.close(completion:{
        print("closed")
      })
      done.lock()
      done.wait()
      done.unlock()
    } catch (let error) {
      print("ERROR B: \(error)")
    }

    if let returnError = returnError {
      throw returnError
    }
    return returnMessage
  }

  // Call this to receive a message.
  // The callback will be called when a message is received.
  // call this again from the callback to wait for another message.
  fileprivate func receiveMessage(callback:@escaping (Echo_EchoResponse?) throws -> Void)
    throws {
      try call.receiveMessage() {(data) in
        guard let data = data else {
          try callback(nil)
          return
        }
        guard
          let responseMessage = try? Echo_EchoResponse(protobuf:data)
          else {
            return
        }
        try callback(responseMessage)
      }
  }

}

//
// Bidirectional-streaming UPDATE
//
public class Echo_EchoUpdateCall {
  var call : Call

  fileprivate init(_ channel: Channel) {
    self.call = channel.makeCall("/echo.Echo/Update")
  }

  fileprivate func run(metadata:Metadata) throws -> Echo_EchoUpdateCall {
    try self.call.start(metadata: metadata, completion:{})
    return self
  }

  fileprivate func receiveMessage(callback:@escaping (Echo_EchoResponse?) throws -> Void) throws {
    try call.receiveMessage() {(data) in
      if let data = data {
        if let responseMessage = try? Echo_EchoResponse(protobuf:data) {
          try callback(responseMessage)
        } else {
          try callback(nil) // error, bad data
        }
      } else {
        try callback(nil)
      }
    }
  }

  public func Receive() throws -> Echo_EchoResponse {
    var returnError : Echo_EchoClientError?
    var returnMessage : Echo_EchoResponse!
    let done = NSCondition()
    do {
      try call.receiveMessage() {(data) in
        if let data = data {
          returnMessage = try? Echo_EchoResponse(protobuf:data)
          if returnMessage == nil {
            returnError = Echo_EchoClientError.invalidMessageReceived
          }
        } else {
          returnError = Echo_EchoClientError.endOfStream
        }
        done.lock()
        done.signal()
        done.unlock()
      }
      done.lock()
      done.wait()
      done.unlock()
    }
    if let returnError = returnError {
      throw returnError
    }
    return returnMessage
  }

  public func Send(_ message:Echo_EchoRequest) {
    let messageData = try! message.serializeProtobuf()
    _ = call.sendMessage(data:messageData)
  }

  public func CloseSend() {
    let done = NSCondition()
    try! call.close() {
      done.lock()
      done.signal()
      done.unlock()
    }
    done.lock()
    done.wait()
    done.unlock()
  }
}

// Call methods of this class to make API calls.
public class Echo_EchoService {
  private var channel: Channel

  public var metadata : Metadata

  public var host : String {
    get {
      return self.channel.host
    }
    set {
      self.channel.host = newValue
    }
  }

  public init(address: String) {
    gRPC.initialize()
    channel = Channel(address:address)
    metadata = Metadata()
  }

  public init(address: String, certificates: String?, host: String?) {
    gRPC.initialize()
    channel = Channel(address:address, certificates:certificates, host:host)
    metadata = Metadata()
  }

  // Synchronous. Unary.
  public func get(_ request: Echo_EchoRequest) throws -> Echo_EchoResponse {
    return try Echo_EchoGetCall(channel).run(request:request, metadata:metadata)
  }

  // Asynchronous. Server-streaming.
  // Send the initial message.
  // Use methods on the returned object to get streamed responses.
  public func expand(_ request: Echo_EchoRequest) throws -> Echo_EchoExpandCall {
    return try Echo_EchoExpandCall(channel).run(request:request, metadata:metadata)
  }

  // Asynchronous. Client-streaming.
  // Use methods on the returned object to stream messages and
  // to close the connection and wait for a final response.
  public func collect() throws -> Echo_EchoCollectCall {
    return try Echo_EchoCollectCall(channel).run(metadata:metadata)
  }

  // Asynchronous. Bidirectional-streaming.
  // Use methods on the returned object to stream messages,
  // to wait for replies, and to close the connection.
  public func update() throws -> Echo_EchoUpdateCall {
    return try Echo_EchoUpdateCall(channel).run(metadata:metadata)
  }
}
