#if !canImport(ObjectiveC)
import XCTest

extension ClientCancellingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ClientCancellingTests = [
        ("testBidirectionalStreaming", testBidirectionalStreaming),
        ("testClientStreaming", testClientStreaming),
        ("testServerStreaming", testServerStreaming),
        ("testUnary", testUnary),
    ]
}

extension ClientClosedChannelTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ClientClosedChannelTests = [
        ("testBidirectionalStreamingOnClosedConnection", testBidirectionalStreamingOnClosedConnection),
        ("testBidirectionalStreamingWhenConnectionIsClosedBetweenMessages", testBidirectionalStreamingWhenConnectionIsClosedBetweenMessages),
        ("testBidirectionalStreamingWithNoPromiseWhenConnectionIsClosedBetweenMessages", testBidirectionalStreamingWithNoPromiseWhenConnectionIsClosedBetweenMessages),
        ("testClientStreamingOnClosedConnection", testClientStreamingOnClosedConnection),
        ("testClientStreamingWhenConnectionIsClosedBetweenMessages", testClientStreamingWhenConnectionIsClosedBetweenMessages),
        ("testServerStreamingOnClosedConnection", testServerStreamingOnClosedConnection),
        ("testUnaryOnClosedConnection", testUnaryOnClosedConnection),
    ]
}

extension ClientTLSFailureTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ClientTLSFailureTests = [
        ("testClientConnectionFailsWhenHostnameIsNotValid", testClientConnectionFailsWhenHostnameIsNotValid),
        ("testClientConnectionFailsWhenProtocolCanNotBeNegotiated", testClientConnectionFailsWhenProtocolCanNotBeNegotiated),
        ("testClientConnectionFailsWhenServerIsUnknown", testClientConnectionFailsWhenServerIsUnknown),
    ]
}

extension ClientThrowingWhenServerReturningErrorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ClientThrowingWhenServerReturningErrorTests = [
        ("testBidirectionalStreaming", testBidirectionalStreaming),
        ("testClientStreaming", testClientStreaming),
        ("testServerStreaming", testServerStreaming),
        ("testUnary", testUnary),
    ]
}

extension ClientTimeoutTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ClientTimeoutTests = [
        ("testBidirectionalStreamingTimeoutAfterSending", testBidirectionalStreamingTimeoutAfterSending),
        ("testBidirectionalStreamingTimeoutBeforeSending", testBidirectionalStreamingTimeoutBeforeSending),
        ("testClientStreamingTimeoutAfterSending", testClientStreamingTimeoutAfterSending),
        ("testClientStreamingTimeoutBeforeSending", testClientStreamingTimeoutBeforeSending),
        ("testServerStreamingTimeoutAfterSending", testServerStreamingTimeoutAfterSending),
        ("testUnaryTimeoutAfterSending", testUnaryTimeoutAfterSending),
    ]
}

extension FunctionalTestsAnonymousClient {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FunctionalTestsAnonymousClient = [
        ("testBidirectionalStreamingBatched", testBidirectionalStreamingBatched),
        ("testBidirectionalStreamingLotsOfMessagesBatched", testBidirectionalStreamingLotsOfMessagesBatched),
        ("testBidirectionalStreamingLotsOfMessagesPingPong", testBidirectionalStreamingLotsOfMessagesPingPong),
        ("testBidirectionalStreamingPingPong", testBidirectionalStreamingPingPong),
        ("testClientStreaming", testClientStreaming),
        ("testClientStreamingLotsOfMessages", testClientStreamingLotsOfMessages),
        ("testServerStreaming", testServerStreaming),
        ("testServerStreamingLotsOfMessages", testServerStreamingLotsOfMessages),
        ("testUnary", testUnary),
        ("testUnaryEmptyRequest", testUnaryEmptyRequest),
        ("testUnaryLotsOfRequests", testUnaryLotsOfRequests),
        ("testUnaryWithLargeData", testUnaryWithLargeData),
    ]
}

extension FunctionalTestsInsecureTransport {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FunctionalTestsInsecureTransport = [
        ("testBidirectionalStreamingBatched", testBidirectionalStreamingBatched),
        ("testBidirectionalStreamingLotsOfMessagesBatched", testBidirectionalStreamingLotsOfMessagesBatched),
        ("testBidirectionalStreamingLotsOfMessagesPingPong", testBidirectionalStreamingLotsOfMessagesPingPong),
        ("testBidirectionalStreamingPingPong", testBidirectionalStreamingPingPong),
        ("testClientStreaming", testClientStreaming),
        ("testClientStreamingLotsOfMessages", testClientStreamingLotsOfMessages),
        ("testServerStreaming", testServerStreaming),
        ("testServerStreamingLotsOfMessages", testServerStreamingLotsOfMessages),
        ("testUnary", testUnary),
        ("testUnaryEmptyRequest", testUnaryEmptyRequest),
        ("testUnaryLotsOfRequests", testUnaryLotsOfRequests),
        ("testUnaryWithLargeData", testUnaryWithLargeData),
    ]
}

extension FunctionalTestsMutualAuthentication {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FunctionalTestsMutualAuthentication = [
        ("testBidirectionalStreamingBatched", testBidirectionalStreamingBatched),
        ("testBidirectionalStreamingLotsOfMessagesBatched", testBidirectionalStreamingLotsOfMessagesBatched),
        ("testBidirectionalStreamingLotsOfMessagesPingPong", testBidirectionalStreamingLotsOfMessagesPingPong),
        ("testBidirectionalStreamingPingPong", testBidirectionalStreamingPingPong),
        ("testClientStreaming", testClientStreaming),
        ("testClientStreamingLotsOfMessages", testClientStreamingLotsOfMessages),
        ("testServerStreaming", testServerStreaming),
        ("testServerStreamingLotsOfMessages", testServerStreamingLotsOfMessages),
        ("testUnary", testUnary),
        ("testUnaryEmptyRequest", testUnaryEmptyRequest),
        ("testUnaryLotsOfRequests", testUnaryLotsOfRequests),
        ("testUnaryWithLargeData", testUnaryWithLargeData),
    ]
}

extension GRPCChannelHandlerTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GRPCChannelHandlerTests = [
        ("testImplementedMethodReturnsHeadersMessageAndStatus", testImplementedMethodReturnsHeadersMessageAndStatus),
        ("testImplementedMethodReturnsStatusForBadlyFormedProto", testImplementedMethodReturnsStatusForBadlyFormedProto),
        ("testUnimplementedMethodReturnsUnimplementedStatus", testUnimplementedMethodReturnsUnimplementedStatus),
    ]
}

extension GRPCInsecureInteroperabilityTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GRPCInsecureInteroperabilityTests = [
        ("testCacheableUnary", testCacheableUnary),
        ("testCancelAfterBegin", testCancelAfterBegin),
        ("testCancelAfterFirstResponse", testCancelAfterFirstResponse),
        ("testClientStreaming", testClientStreaming),
        ("testCustomMetadata", testCustomMetadata),
        ("testEmptyStream", testEmptyStream),
        ("testEmptyUnary", testEmptyUnary),
        ("testLargeUnary", testLargeUnary),
        ("testPingPong", testPingPong),
        ("testServerStreaming", testServerStreaming),
        ("testSpecialStatusAndMessage", testSpecialStatusAndMessage),
        ("testStatusCodeAndMessage", testStatusCodeAndMessage),
        ("testTimeoutOnSleepingServer", testTimeoutOnSleepingServer),
        ("testUnimplementedMethod", testUnimplementedMethod),
        ("testUnimplementedService", testUnimplementedService),
    ]
}

extension GRPCSecureInteroperabilityTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GRPCSecureInteroperabilityTests = [
        ("testCacheableUnary", testCacheableUnary),
        ("testCancelAfterBegin", testCancelAfterBegin),
        ("testCancelAfterFirstResponse", testCancelAfterFirstResponse),
        ("testClientStreaming", testClientStreaming),
        ("testCustomMetadata", testCustomMetadata),
        ("testEmptyStream", testEmptyStream),
        ("testEmptyUnary", testEmptyUnary),
        ("testLargeUnary", testLargeUnary),
        ("testPingPong", testPingPong),
        ("testServerStreaming", testServerStreaming),
        ("testSpecialStatusAndMessage", testSpecialStatusAndMessage),
        ("testStatusCodeAndMessage", testStatusCodeAndMessage),
        ("testTimeoutOnSleepingServer", testTimeoutOnSleepingServer),
        ("testUnimplementedMethod", testUnimplementedMethod),
        ("testUnimplementedService", testUnimplementedService),
    ]
}

extension GRPCStatusCodeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GRPCStatusCodeTests = [
        ("testBadGateway", testBadGateway),
        ("testBadRequest", testBadRequest),
        ("testForbidden", testForbidden),
        ("testGatewayTimeout", testGatewayTimeout),
        ("testNotFound", testNotFound),
        ("testServiceUnavailable", testServiceUnavailable),
        ("testStatusCodeAndMessageAreRespectedForNon200Responses", testStatusCodeAndMessageAreRespectedForNon200Responses),
        ("testTooManyRequests", testTooManyRequests),
        ("testUnauthorized", testUnauthorized),
    ]
}

extension GRPCStatusMessageMarshallerTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GRPCStatusMessageMarshallerTests = [
        ("testASCIIMarshallingAndUnmarshalling", testASCIIMarshallingAndUnmarshalling),
        ("testPercentMarshallingAndUnmarshalling", testPercentMarshallingAndUnmarshalling),
        ("testUnicodeMarshalling", testUnicodeMarshalling),
    ]
}

extension GRPCTypeSizeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__GRPCTypeSizeTests = [
        ("testGRPCClientRequestPart", testGRPCClientRequestPart),
        ("testGRPCClientResponsePart", testGRPCClientResponsePart),
        ("testGRPCStatus", testGRPCStatus),
        ("testRawGRPCClientRequestPart", testRawGRPCClientRequestPart),
        ("testRawGRPCClientResponsePart", testRawGRPCClientResponsePart),
    ]
}

extension HTTP1ToRawGRPCServerCodecTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__HTTP1ToRawGRPCServerCodecTests = [
        ("testInternalErrorStatusIsReturnedIfMessageCannotBeDeserialized", testInternalErrorStatusIsReturnedIfMessageCannotBeDeserialized),
        ("testInternalErrorStatusIsReturnedWhenSendingTrailersInRequest", testInternalErrorStatusIsReturnedWhenSendingTrailersInRequest),
        ("testInternalErrorStatusReturnedWhenCompressionFlagIsSet", testInternalErrorStatusReturnedWhenCompressionFlagIsSet),
        ("testMessageCanBeSentAcrossMultipleByteBuffers", testMessageCanBeSentAcrossMultipleByteBuffers),
        ("testOnlyOneStatusIsReturned", testOnlyOneStatusIsReturned),
    ]
}

extension LengthPrefixedMessageReaderTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__LengthPrefixedMessageReaderTests = [
        ("testAppendReadsAllBytes", testAppendReadsAllBytes),
        ("testNextMessageDeliveredAcrossMultipleByteBuffers", testNextMessageDeliveredAcrossMultipleByteBuffers),
        ("testNextMessageDoesNotThrowWhenCompressionFlagIsExpectedButNotSet", testNextMessageDoesNotThrowWhenCompressionFlagIsExpectedButNotSet),
        ("testNextMessageReturnsMessageForZeroLengthMessage", testNextMessageReturnsMessageForZeroLengthMessage),
        ("testNextMessageReturnsMessageIsAppendedInOneBuffer", testNextMessageReturnsMessageIsAppendedInOneBuffer),
        ("testNextMessageReturnsNilWhenNoBytesAppended", testNextMessageReturnsNilWhenNoBytesAppended),
        ("testNextMessageReturnsNilWhenNoMessageBytesAreAvailable", testNextMessageReturnsNilWhenNoMessageBytesAreAvailable),
        ("testNextMessageReturnsNilWhenNoMessageLengthIsAvailable", testNextMessageReturnsNilWhenNoMessageLengthIsAvailable),
        ("testNextMessageReturnsNilWhenNotAllMessageBytesAreAvailable", testNextMessageReturnsNilWhenNotAllMessageBytesAreAvailable),
        ("testNextMessageReturnsNilWhenNotAllMessageLengthIsAvailable", testNextMessageReturnsNilWhenNotAllMessageLengthIsAvailable),
        ("testNextMessageThrowsWhenCompressionFlagIsSetButNotExpected", testNextMessageThrowsWhenCompressionFlagIsSetButNotExpected),
        ("testNextMessageThrowsWhenCompressionMechanismIsNotSupported", testNextMessageThrowsWhenCompressionMechanismIsNotSupported),
        ("testNextMessageWhenMultipleMessagesAreBuffered", testNextMessageWhenMultipleMessagesAreBuffered),
    ]
}

extension ServerDelayedThrowingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ServerDelayedThrowingTests = [
        ("testBidirectionalStreaming", testBidirectionalStreaming),
        ("testClientStreaming", testClientStreaming),
        ("testServerStreaming", testServerStreaming),
        ("testUnary", testUnary),
    ]
}

extension ServerErrorTransformingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ServerErrorTransformingTests = [
        ("testBidirectionalStreaming", testBidirectionalStreaming),
        ("testClientStreaming", testClientStreaming),
        ("testServerStreaming", testServerStreaming),
        ("testUnary", testUnary),
    ]
}

extension ServerThrowingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ServerThrowingTests = [
        ("testBidirectionalStreaming", testBidirectionalStreaming),
        ("testClientStreaming", testClientStreaming),
        ("testServerStreaming", testServerStreaming),
        ("testUnary", testUnary),
    ]
}

extension ServerWebTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ServerWebTests = [
        ("testServerStreaming", testServerStreaming),
        ("testUnary", testUnary),
        ("testUnaryLotsOfRequests", testUnaryLotsOfRequests),
        ("testUnaryWithoutRequestMessage", testUnaryWithoutRequestMessage),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ClientCancellingTests.__allTests__ClientCancellingTests),
        testCase(ClientClosedChannelTests.__allTests__ClientClosedChannelTests),
        testCase(ClientTLSFailureTests.__allTests__ClientTLSFailureTests),
        testCase(ClientThrowingWhenServerReturningErrorTests.__allTests__ClientThrowingWhenServerReturningErrorTests),
        testCase(ClientTimeoutTests.__allTests__ClientTimeoutTests),
        testCase(FunctionalTestsAnonymousClient.__allTests__FunctionalTestsAnonymousClient),
        testCase(FunctionalTestsInsecureTransport.__allTests__FunctionalTestsInsecureTransport),
        testCase(FunctionalTestsMutualAuthentication.__allTests__FunctionalTestsMutualAuthentication),
        testCase(GRPCChannelHandlerTests.__allTests__GRPCChannelHandlerTests),
        testCase(GRPCInsecureInteroperabilityTests.__allTests__GRPCInsecureInteroperabilityTests),
        testCase(GRPCSecureInteroperabilityTests.__allTests__GRPCSecureInteroperabilityTests),
        testCase(GRPCStatusCodeTests.__allTests__GRPCStatusCodeTests),
        testCase(GRPCStatusMessageMarshallerTests.__allTests__GRPCStatusMessageMarshallerTests),
        testCase(GRPCTypeSizeTests.__allTests__GRPCTypeSizeTests),
        testCase(HTTP1ToRawGRPCServerCodecTests.__allTests__HTTP1ToRawGRPCServerCodecTests),
        testCase(LengthPrefixedMessageReaderTests.__allTests__LengthPrefixedMessageReaderTests),
        testCase(ServerDelayedThrowingTests.__allTests__ServerDelayedThrowingTests),
        testCase(ServerErrorTransformingTests.__allTests__ServerErrorTransformingTests),
        testCase(ServerThrowingTests.__allTests__ServerThrowingTests),
        testCase(ServerWebTests.__allTests__ServerWebTests),
    ]
}
#endif
