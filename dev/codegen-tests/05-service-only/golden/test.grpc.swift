//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: test.proto
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
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate Codegentest_FooClient, then call methods of this protocol to make API calls.
internal protocol Codegentest_FooClientProtocol: GRPCClient {
  var interceptors: Codegentest_FooClientInterceptorFactoryProtocol? { get }

  func bar(
    _ request: SwiftProtobuf.Google_Protobuf_Empty,
    callOptions: CallOptions?
  ) -> UnaryCall<SwiftProtobuf.Google_Protobuf_Empty, SwiftProtobuf.Google_Protobuf_Empty>
}

extension Codegentest_FooClientProtocol {

  /// Unary call to Bar
  ///
  /// - Parameters:
  ///   - request: Request to send to Bar.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func bar(
    _ request: SwiftProtobuf.Google_Protobuf_Empty,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<SwiftProtobuf.Google_Protobuf_Empty, SwiftProtobuf.Google_Protobuf_Empty> {
    return self.makeUnaryCall(
      path: "/codegentest.Foo/Bar",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeBarInterceptors() ?? []
    )
  }
}

internal protocol Codegentest_FooClientInterceptorFactoryProtocol {
  /// Makes an array of generic interceptors. The per-method interceptor
  /// factories default to calling this function and it therefore provides a
  /// convenient way of setting interceptors for all methods on a client.
  /// - Returns: An array of interceptors generic over `Request` and `Response`.
  ///   Defaults to an empty array.
  func makeInterceptors<Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message>() -> [ClientInterceptor<Request, Response>]

  /// - Returns: Interceptors to use when invoking 'bar'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeBarInterceptors() -> [ClientInterceptor<SwiftProtobuf.Google_Protobuf_Empty, SwiftProtobuf.Google_Protobuf_Empty>]
}

extension Codegentest_FooClientInterceptorFactoryProtocol {
  internal func makeInterceptors<Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message>() -> [ClientInterceptor<Request, Response>] {
    return []
  }

  internal func makeBarInterceptors() -> [ClientInterceptor<SwiftProtobuf.Google_Protobuf_Empty, SwiftProtobuf.Google_Protobuf_Empty>] {
    return self.makeInterceptors()
  }
}

internal final class Codegentest_FooClient: Codegentest_FooClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Codegentest_FooClientInterceptorFactoryProtocol?

  /// Creates a client for the codegentest.Foo service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Codegentest_FooClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Codegentest_FooProvider: CallHandlerProvider {
  func bar(request: SwiftProtobuf.Google_Protobuf_Empty, context: StatusOnlyCallContext) -> EventLoopFuture<SwiftProtobuf.Google_Protobuf_Empty>
}

extension Codegentest_FooProvider {
  internal var serviceName: Substring { return "codegentest.Foo" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handleMethod(_ methodName: Substring, callHandlerContext: CallHandlerContext) -> GRPCCallHandler? {
    switch methodName {
    case "Bar":
      return CallHandlerFactory.makeUnary(callHandlerContext: callHandlerContext) { context in
        return { request in
          self.bar(request: request, context: context)
        }
      }

    default: return nil
    }
  }
}

