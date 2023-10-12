//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: reflection.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Reflection_ServerReflectionClient`, then call methods of this protocol to make API calls.
internal protocol Reflection_ServerReflectionClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol? { get }

  func serverReflectionInfo(
    callOptions: CallOptions?,
    handler: @escaping (Reflection_ServerReflectionResponse) -> Void
  ) -> BidirectionalStreamingCall<Reflection_ServerReflectionRequest, Reflection_ServerReflectionResponse>
}

extension Reflection_ServerReflectionClientProtocol {
  internal var serviceName: String {
    return "reflection.ServerReflection"
  }

  /// The reflection service is structured as a bidirectional stream, ensuring
  /// all related requests go to a single server.
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata and status.
  internal func serverReflectionInfo(
    callOptions: CallOptions? = nil,
    handler: @escaping (Reflection_ServerReflectionResponse) -> Void
  ) -> BidirectionalStreamingCall<Reflection_ServerReflectionRequest, Reflection_ServerReflectionResponse> {
    return self.makeBidirectionalStreamingCall(
      path: Reflection_ServerReflectionClientMetadata.Methods.serverReflectionInfo.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeServerReflectionInfoInterceptors() ?? [],
      handler: handler
    )
  }
}

@available(*, deprecated)
extension Reflection_ServerReflectionClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Reflection_ServerReflectionNIOClient")
internal final class Reflection_ServerReflectionClient: Reflection_ServerReflectionClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the reflection.ServerReflection service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Reflection_ServerReflectionNIOClient: Reflection_ServerReflectionClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol?

  /// Creates a client for the reflection.ServerReflection service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Reflection_ServerReflectionAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol? { get }

  func makeServerReflectionInfoCall(
    callOptions: CallOptions?
  ) -> GRPCAsyncBidirectionalStreamingCall<Reflection_ServerReflectionRequest, Reflection_ServerReflectionResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Reflection_ServerReflectionAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Reflection_ServerReflectionClientMetadata.serviceDescriptor
  }

  internal var interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeServerReflectionInfoCall(
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncBidirectionalStreamingCall<Reflection_ServerReflectionRequest, Reflection_ServerReflectionResponse> {
    return self.makeAsyncBidirectionalStreamingCall(
      path: Reflection_ServerReflectionClientMetadata.Methods.serverReflectionInfo.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeServerReflectionInfoInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Reflection_ServerReflectionAsyncClientProtocol {
  internal func serverReflectionInfo<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<Reflection_ServerReflectionResponse> where RequestStream: Sequence, RequestStream.Element == Reflection_ServerReflectionRequest {
    return self.performAsyncBidirectionalStreamingCall(
      path: Reflection_ServerReflectionClientMetadata.Methods.serverReflectionInfo.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeServerReflectionInfoInterceptors() ?? []
    )
  }

  internal func serverReflectionInfo<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<Reflection_ServerReflectionResponse> where RequestStream: AsyncSequence & Sendable, RequestStream.Element == Reflection_ServerReflectionRequest {
    return self.performAsyncBidirectionalStreamingCall(
      path: Reflection_ServerReflectionClientMetadata.Methods.serverReflectionInfo.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeServerReflectionInfoInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Reflection_ServerReflectionAsyncClient: Reflection_ServerReflectionAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Reflection_ServerReflectionClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Reflection_ServerReflectionClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'serverReflectionInfo'.
  func makeServerReflectionInfoInterceptors() -> [ClientInterceptor<Reflection_ServerReflectionRequest, Reflection_ServerReflectionResponse>]
}

internal enum Reflection_ServerReflectionClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "ServerReflection",
    fullName: "reflection.ServerReflection",
    methods: [
      Reflection_ServerReflectionClientMetadata.Methods.serverReflectionInfo,
    ]
  )

  internal enum Methods {
    internal static let serverReflectionInfo = GRPCMethodDescriptor(
      name: "ServerReflectionInfo",
      path: "/reflection.ServerReflection/ServerReflectionInfo",
      type: GRPCCallType.bidirectionalStreaming
    )
  }
}

