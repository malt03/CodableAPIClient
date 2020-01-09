import XCTest
@testable import CodableAPIClient

final class CodableAPIClientTests: XCTestCase {
    let successTestCases: [Runnable] = [
        APIRequestTestCase(SuccessRequest(method: .delete), "https://httpbin.org/delete",        1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase(SuccessRequest(method: .get),    "https://httpbin.org/get?a=c&b=d", nil, .init(args: .init(), json: nil),    nil),
        APIRequestTestCase(SuccessRequest(method: .patch),  "https://httpbin.org/patch",         1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase(SuccessRequest(method: .post),   "https://httpbin.org/post",          1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase(SuccessRequest(method: .put),    "https://httpbin.org/put",           1, .init(args: .nil(), json: .init()), nil),
    ]
    
    let statusCodeTestCases: [Runnable] = [
        APIRequestTestCase(StatusCodeRequest(statusCode: 301), "https://httpbin.org/status/301", nil, .init(), nil),
        APIRequestTestCase(StatusCodeRequest(statusCode: 400), "https://httpbin.org/status/400", nil, nil,     "400 Bad Request"),
        APIRequestTestCase(StatusCodeRequest(statusCode: 500), "https://httpbin.org/status/500", nil, nil,     "500 Internal Server Error"),
    ]
    
    let unexpectedMimeTypeTestCases: [Runnable] = [
        APIRequestTestCase(XMLRequest(), "https://httpbin.org/xml", nil, nil, "Unexpected Mime Type: application/xml"),
    ]
    
    let delayTestCases: [Runnable] = [
        APIRequestTestCase(DelayRequest(delay: 2, timeoutInterval: 1), "https://httpbin.org/delay/2", nil, nil,    "The request timed out."),
        APIRequestTestCase(DelayRequest(delay: 2, timeoutInterval: 3), "https://httpbin.org/delay/2", nil, .init(), nil),
    ]

    func testSuccess() {
        successTestCases.forEach { $0.run() }
    }

    func testStatusCode() {
        statusCodeTestCases.forEach { $0.run() }
    }
    
    func testUnexpectedMimeType() {
        unexpectedMimeTypeTestCases.forEach { $0.run() }
    }

    func testDelay() {
        delayTestCases.forEach { $0.run() }
    }

    static var allTests = [
        ("testSuccess", testSuccess),
    ]
}
