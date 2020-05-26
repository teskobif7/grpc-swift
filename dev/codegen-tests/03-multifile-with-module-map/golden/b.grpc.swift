//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: b.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation
import GRPC
import NIO
import NIOHTTP1
import SwiftProtobuf


/// Usage: instantiate B_ServiceBClient, then call methods of this protocol to make API calls.
internal protocol B_ServiceBClientProtocol {
  func callServiceB(_ request: B_MessageB, callOptions: CallOptions?) -> UnaryCall<B_MessageB, SwiftProtobuf.Google_Protobuf_Empty>
}

internal final class B_ServiceBClient: GRPCClient, B_ServiceBClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions

  /// Creates a client for the b.ServiceB service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  internal init(channel: GRPCChannel, defaultCallOptions: CallOptions = CallOptions()) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
  }

  /// Unary call to CallServiceB
  ///
  /// - Parameters:
  ///   - request: Request to send to CallServiceB.
  ///   - callOptions: Call options; `self.defaultCallOptions` is used if `nil`.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func callServiceB(_ request: B_MessageB, callOptions: CallOptions? = nil) -> UnaryCall<B_MessageB, SwiftProtobuf.Google_Protobuf_Empty> {
    return self.makeUnaryCall(path: "/b.ServiceB/CallServiceB",
                              request: request,
                              callOptions: callOptions ?? self.defaultCallOptions)
  }

}

/// To build a server, implement a class that conforms to this protocol.
internal protocol B_ServiceBProvider: CallHandlerProvider {
  func callServiceB(request: B_MessageB, context: StatusOnlyCallContext) -> EventLoopFuture<SwiftProtobuf.Google_Protobuf_Empty>
}

extension B_ServiceBProvider {
  internal var serviceName: String { return "b.ServiceB" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handleMethod(_ methodName: String, callHandlerContext: CallHandlerContext) -> GRPCCallHandler? {
    switch methodName {
    case "CallServiceB":
      return UnaryCallHandler(callHandlerContext: callHandlerContext) { context in
        return { request in
          self.callServiceB(request: request, context: context)
        }
      }

    default: return nil
    }
  }
}


// Provides conformance to `GRPCPayload`
extension B_MessageB: GRPCProtobufPayload {}
