import XCTest
@testable import CodableAPIClient

final class CodableAPIClientTests: XCTestCase {
    let successTestCases: [Runnable] = [
        APIRequestTestCase(SuccessRequest(method: .delete), "http://localhost/delete",        1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase(SuccessRequest(method: .get),    "http://localhost/get?a=c&b=d", nil, .init(args: .init(), json: nil),    nil),
        APIRequestTestCase(SuccessRequest(method: .patch),  "http://localhost/patch",         1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase(SuccessRequest(method: .post),   "http://localhost/post",          1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase(SuccessRequest(method: .put),    "http://localhost/put",           1, .init(args: .nil(), json: .init()), nil),
    ]
    
    let statusCodeTestCases: [Runnable] = [
        APIRequestTestCase(StatusCodeRequest(statusCode: 301), "http://localhost/status/301", nil, .init(), nil),
        APIRequestTestCase(StatusCodeRequest(statusCode: 400), "http://localhost/status/400", nil, nil,     "400 Bad Request"),
        APIRequestTestCase(StatusCodeRequest(statusCode: 500), "http://localhost/status/500", nil, nil,     "500 Internal Server Error"),
    ]
    
    let unexpectedMimeTypeTestCases: [Runnable] = [
        APIRequestTestCase(XMLRequest(), "http://localhost/xml", nil, nil, "Unexpected Mime Type: application/xml"),
    ]
    
    let delayTestCases: [Runnable] = [
        APIRequestTestCase(DelayRequest(delay: 2, timeoutInterval: 1), "http://localhost/delay/2", nil, nil,    "The request timed out."),
        APIRequestTestCase(DelayRequest(delay: 2, timeoutInterval: 3), "http://localhost/delay/2", nil, .init(), nil),
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
