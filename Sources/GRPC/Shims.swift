/*
 * Copyright 2019, gRPC Authors All rights reserved.
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
import NIO
import NIOSSL
import NIOHPACK

// This file contains shims to notify users of API changes between v1.0.0-alpha.1 and v1.0.0.

// TODO: Remove these shims before v1.0.0 is tagged.

extension ClientConnection.Configuration {
  @available(*, deprecated, message: "use 'tls' and 'ClientConnection.Configuration.TLS'")
  public var tlsConfiguration: TLSConfiguration? {
    return nil
  }
}

extension Server.Configuration {
  @available(*, deprecated, message: "use 'tls' and 'Server.Configuration.TLS'")
  public var tlsConfiguration: TLSConfiguration? {
    return nil
  }
}

@available(*, deprecated, renamed: "PlatformSupport")
public enum GRPCNIO {}

extension ClientErrorDelegate {
  @available(*, deprecated, message: "Please use 'didCatchError(_:logger:file:line:)' instead")
  public func didCatchError(_ error: Error, file: StaticString, line: Int) { }
}

extension GRPCStatusTransformable {
  @available(*, deprecated, renamed: "makeGRPCStatus")
  func asGRPCStatus() -> GRPCStatus {
    return self.makeGRPCStatus()
  }
}

extension GRPCClient {
  @available(*, deprecated, renamed: "channel")
  public var connection: GRPCChannel {
    return self.channel
  }
}

extension CallOptions {
  @available(*, deprecated, renamed: "init(customMetadata:timeLimit:messageEncoding:requestIDProvider:requestIDHeader:cacheable:)")
  public init(
    customMetadata: HPACKHeaders = HPACKHeaders(),
    timeout: GRPCTimeout,
    messageEncoding: ClientMessageEncoding = .disabled,
    requestIDProvider: RequestIDProvider = .autogenerated,
    requestIDHeader: String? = nil,
    cacheable: Bool = false
  ) {
    self.init(
      customMetadata: customMetadata,
      timeLimit: .timeout(timeout.asNIOTimeAmount),
      messageEncoding: messageEncoding,
      requestIDProvider: requestIDProvider,
      requestIDHeader: requestIDHeader,
      cacheable: cacheable
    )
  }

  // TODO: `timeLimit.wrapped` can be private when the shims are removed.
  @available(*, deprecated, renamed: "timeLimit")
  public var timeout: GRPCTimeout {
    get {
      switch self.timeLimit.wrapped {
      case .none:
        return .infinite

      case .timeout(let timeout) where timeout.nanoseconds == .max:
        return .infinite

      case .deadline(let deadline) where deadline == .distantFuture:
        return .infinite

      case .timeout(let timeout):
        return GRPCTimeout.nanoseconds(rounding: Int(timeout.nanoseconds))

      case .deadline(let deadline):
        return GRPCTimeout(deadline: deadline)
      }
    }
    set {
      self.timeLimit = .timeout(newValue.asNIOTimeAmount)
    }
  }
}

extension GRPCTimeout {
  /// Creates a new GRPCTimeout for the given amount of hours.
  ///
  /// `amount` must be positive and at most 8-digits.
  ///
  /// - Parameter amount: the amount of hours this `GRPCTimeout` represents.
  /// - Returns: A `GRPCTimeout` representing the given number of hours.
  /// - Throws: `GRPCTimeoutError` if the amount was negative or more than 8 digits long.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func hours(_ amount: Int) throws -> GRPCTimeout {
    return try makeTimeout(Int64(amount), .hours)
  }

  /// Creates a new GRPCTimeout for the given amount of hours.
  ///
  /// The timeout will be rounded up if it may not be represented in the wire format.
  ///
  /// - Parameter amount: The number of hours to represent.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func hours(rounding amount: Int) -> GRPCTimeout {
    return .init(rounding: Int64(amount), unit: .hours)
  }

  /// Creates a new GRPCTimeout for the given amount of minutes.
  ///
  /// `amount` must be positive and at most 8-digits.
  ///
  /// - Parameter amount: the amount of minutes this `GRPCTimeout` represents.
  /// - Returns: A `GRPCTimeout` representing the given number of minutes.
  /// - Throws: `GRPCTimeoutError` if the amount was negative or more than 8 digits long.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func minutes(_ amount: Int) throws -> GRPCTimeout {
    return try makeTimeout(Int64(amount), .minutes)
  }

  /// Creates a new GRPCTimeout for the given amount of minutes.
  ///
  /// The timeout will be rounded up if it may not be represented in the wire format.
  ///
  /// - Parameter amount: The number of minutes to represent.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func minutes(rounding amount: Int) -> GRPCTimeout {
    return .init(rounding: Int64(amount), unit: .minutes)
  }

  /// Creates a new GRPCTimeout for the given amount of seconds.
  ///
  /// `amount` must be positive and at most 8-digits.
  ///
  /// - Parameter amount: the amount of seconds this `GRPCTimeout` represents.
  /// - Returns: A `GRPCTimeout` representing the given number of seconds.
  /// - Throws: `GRPCTimeoutError` if the amount was negative or more than 8 digits long.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func seconds(_ amount: Int) throws -> GRPCTimeout {
    return try makeTimeout(Int64(amount), .seconds)
  }

  /// Creates a new GRPCTimeout for the given amount of seconds.
  ///
  /// The timeout will be rounded up if it may not be represented in the wire format.
  ///
  /// - Parameter amount: The number of seconds to represent.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func seconds(rounding amount: Int) -> GRPCTimeout {
    return .init(rounding: Int64(amount), unit: .seconds)
  }

  /// Creates a new GRPCTimeout for the given amount of milliseconds.
  ///
  /// `amount` must be positive and at most 8-digits.
  ///
  /// - Parameter amount: the amount of milliseconds this `GRPCTimeout` represents.
  /// - Returns: A `GRPCTimeout` representing the given number of milliseconds.
  /// - Throws: `GRPCTimeoutError` if the amount was negative or more than 8 digits long.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func milliseconds(_ amount: Int) throws -> GRPCTimeout {
    return try makeTimeout(Int64(amount), .milliseconds)
  }

  /// Creates a new GRPCTimeout for the given amount of milliseconds.
  ///
  /// The timeout will be rounded up if it may not be represented in the wire format.
  ///
  /// - Parameter amount: The number of milliseconds to represent.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func milliseconds(rounding amount: Int) -> GRPCTimeout {
    return .init(rounding: Int64(amount), unit: .milliseconds)
  }

  /// Creates a new GRPCTimeout for the given amount of microseconds.
  ///
  /// `amount` must be positive and at most 8-digits.
  ///
  /// - Parameter amount: the amount of microseconds this `GRPCTimeout` represents.
  /// - Returns: A `GRPCTimeout` representing the given number of microseconds.
  /// - Throws: `GRPCTimeoutError` if the amount was negative or more than 8 digits long.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func microseconds(_ amount: Int) throws -> GRPCTimeout {
    return try makeTimeout(Int64(amount), .microseconds)
  }

  /// Creates a new GRPCTimeout for the given amount of microseconds.
  ///
  /// The timeout will be rounded up if it may not be represented in the wire format.
  ///
  /// - Parameter amount: The number of microseconds to represent.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func microseconds(rounding amount: Int) -> GRPCTimeout {
    return .init(rounding: Int64(amount), unit: .microseconds)
  }

  /// Creates a new GRPCTimeout for the given amount of nanoseconds.
  ///
  /// `amount` must be positive and at most 8-digits.
  ///
  /// - Parameter amount: the amount of nanoseconds this `GRPCTimeout` represents.
  /// - Returns: A `GRPCTimeout` representing the given number of nanoseconds.
  /// - Throws: `GRPCTimeoutError` if the amount was negative or more than 8 digits long.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func nanoseconds(_ amount: Int) throws -> GRPCTimeout {
    return try makeTimeout(Int64(amount), .nanoseconds)
  }

  /// Creates a new GRPCTimeout for the given amount of nanoseconds.
  ///
  /// The timeout will be rounded up if it may not be represented in the wire format.
  ///
  /// - Parameter amount: The number of nanoseconds to represent.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public static func nanoseconds(rounding amount: Int) -> GRPCTimeout {
    return .init(rounding: Int64(amount), unit: .nanoseconds)
  }
}

extension GRPCTimeout {
  /// Returns a NIO `TimeAmount` representing the amount of time as this timeout.
  @available(*, deprecated, message: "Use 'TimeLimit.timeout(_:)' or 'TimeLimit.deadline(_:)' instead.")
  public var asNIOTimeAmount: TimeAmount {
    return TimeAmount.nanoseconds(numericCast(nanoseconds))
  }

  internal static func makeTimeout(_ amount: Int64, _ unit: GRPCTimeoutUnit) throws -> GRPCTimeout {
    // Timeouts must be positive and at most 8-digits.
    if amount < 0 {
      throw GRPCTimeoutError.negative
    }
    if amount > GRPCTimeout.maxAmount {
      throw GRPCTimeoutError.tooManyDigits
    }
    return .init(amount: amount, unit: unit)
  }
}

// These will be obsoleted when the shims are removed.

/// Errors thrown when constructing a timeout.
public struct GRPCTimeoutError: Error, Equatable, CustomStringConvertible {
  private enum BaseError {
    case negative
    case tooManyDigits
  }

  private var error: BaseError

  private init(_ error: BaseError) {
    self.error = error
  }

  public var description: String {
    switch self.error {
    case .negative:
      return "GRPCTimeoutError: time amount must not be negative"
    case .tooManyDigits:
      return "GRPCTimeoutError: too many digits to represent using the gRPC wire-format"
    }
  }

  /// The timeout is negative.
  public static let negative = GRPCTimeoutError(.negative)

  /// The number of digits in the timeout amount is more than 8-digits and cannot be encoded in
  /// the gRPC wire-format.
  public static let tooManyDigits = GRPCTimeoutError(.tooManyDigits)
}
