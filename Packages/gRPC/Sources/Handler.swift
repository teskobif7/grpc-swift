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
#if SWIFT_PACKAGE
  import CgRPC
#endif
import Foundation // for String.Encoding

/// A gRPC request handler
public class Handler {
  /// Pointer to underlying C representation
  var h: UnsafeMutableRawPointer!

  /// Completion queue for handler response operations
  public var completionQueue: CompletionQueue

  /// Metadata received with the request
  public var requestMetadata: Metadata

  /// Initializes a Handler
  ///
  /// - Parameter h: the underlying C representation
  init(h:UnsafeMutableRawPointer!) {
    self.h = h;
    self.requestMetadata = Metadata()
    self.completionQueue = CompletionQueue(cq:cgrpc_handler_get_completion_queue(h))
    self.completionQueue.name = "Handler"
  }

  deinit {
    cgrpc_handler_destroy(self.h)
  }

  /// Gets the host name sent with the request
  ///
  /// - Returns: the host name sent with the request
  public func host() -> String {
    return String(cString:cgrpc_handler_host(h), encoding:String.Encoding.utf8)!;
  }

  /// Gets the method name sent with the request
  ///
  /// - Returns: the method name sent with the request
  public func method() -> String {
    return String(cString:cgrpc_handler_method(h), encoding:String.Encoding.utf8)!;
  }

  /// Gets the caller identity associated with the request
  ///
  /// - Returns: a string representing the caller address
  public func caller() -> String {
    return String(cString:cgrpc_handler_call_peer(h), encoding:String.Encoding.utf8)!;
  }

  /// Creates a call object associated with the handler
  ///
  /// - Returns: a Call object that can be used to respond to the request
  func call() -> Call {
    return Call(call: cgrpc_handler_get_call(h), owned:false)
  }

  /// Request a call for the handler
  ///
  /// Fills the handler properties with information about the received request
  ///
  /// - Returns: a grpc_call_error indicating the result of requesting the call
  func requestCall(tag: Int) -> grpc_call_error {
    return cgrpc_handler_request_call(h, requestMetadata.array, tag)
  }

  /// Receive the message sent with a call
  ///
  /// - Returns: a tuple containing status codes and a message (if available)
  public func receiveMessage(initialMetadata: Metadata,
                             completion:((ByteBuffer?) -> Void)) -> Void {
    let call = self.call()
    let operation_sendInitialMetadata = Operation_SendInitialMetadata(metadata:initialMetadata);
    let operation_receiveMessage = Operation_ReceiveMessage()
    let operations = OperationGroup(
      call:call,
      operations:[
        operation_sendInitialMetadata,
        operation_receiveMessage])
    {(event) in
      if (event.type == GRPC_OP_COMPLETE) {
        completion(operation_receiveMessage.message())
      } else {
        completion(nil)
      }
    }

    self.completionQueue.operationGroups[operations.tag] = operations
    _ = call.performOperations(operations:operations, tag:operations.tag, completionQueue: self.completionQueue)
  }

  /// Sends the response to a request
  ///
  /// - Parameter message: the message to send
  /// - Returns: a tuple containing status codes
  public func sendResponse(message: ByteBuffer,
                           trailingMetadata: Metadata) -> Void {
    let call = self.call()
    let operation_receiveCloseOnServer = Operation_ReceiveCloseOnServer();
    let operation_sendStatusFromServer = Operation_SendStatusFromServer(status:0,
                                                                        statusDetails:"OK",
                                                                        metadata:trailingMetadata)
    let operation_sendMessage = Operation_SendMessage(message:message)
    let operations = OperationGroup(
      call:call,
      operations:[
        operation_receiveCloseOnServer,
        operation_sendStatusFromServer,
        operation_sendMessage])
    {(call_error) in
      print("server response complete")
      print("finished with handler \(self)")
      self.shutdown()
    }
    self.completionQueue.operationGroups[operations.tag] = operations
    _ = call.performOperations(operations:operations, tag:operations.tag, completionQueue: self.completionQueue)
  }


  func shutdown() {
    cgrpc_completion_queue_shutdown(completionQueue.cq)
  }
}
