import XCTest
@testable import CodableAPIClient

final class CodableAPIClientTests: XCTestCase {
    let testCases: [Runnable] = [
        // Success
        APIRequestTestCase("Success", SuccessRequest(method: .delete), "http://localhost/delete",        1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase("Success", SuccessRequest(method: .get),    "http://localhost/get?a=c&b=d", nil, .init(args: .init(), json: nil),    nil),
        APIRequestTestCase("Success", SuccessRequest(method: .patch),  "http://localhost/patch",         1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase("Success", SuccessRequest(method: .post),   "http://localhost/post",          1, .init(args: .nil(), json: .init()), nil),
        APIRequestTestCase("Success", SuccessRequest(method: .put),    "http://localhost/put",           1, .init(args: .nil(), json: .init()), nil),

        // Status Code
        APIRequestTestCase("Status Code", StatusCodeRequest(statusCode: 301), "http://localhost/status/301", nil, .init(), nil),
        APIRequestTestCase("Status Code", StatusCodeRequest(statusCode: 400), "http://localhost/status/400", nil, nil,     "400 Bad Request"),
        APIRequestTestCase("Status Code", StatusCodeRequest(statusCode: 500), "http://localhost/status/500", nil, nil,     "500 Internal Server Error"),

        // Unexpected Mime Type
        APIRequestTestCase("Unexpected Mime Type", XMLRequest(), "http://localhost/xml", nil, nil, "Unexpected Mime Type: application/xml"),

        // Delay
        APIRequestTestCase("Delay Failure", DelayRequest(delay: 2, timeoutInterval: 1), "http://localhost/delay/2", nil, nil,    "The request timed out."),
        APIRequestTestCase("Delay Success", DelayRequest(delay: 2, timeoutInterval: 3), "http://localhost/delay/2", nil, .init(), nil),
        
        // Custom Header
        APIRequestTestCase("Custom Header", CustomHeaderRequest(), "http://localhost/get", nil, .init(headers: .init(accept: "application/json", contentType: "application/json", customHeader1: "xxxxx", customHeader2: "yyyyy")), nil),
    ]

    func test() {
        testCases.forEach { $0.run() }
    }

    static var allTests = [
        ("test", test),
    ]
}
