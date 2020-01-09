import XCTest
@testable import CodableAPIClient

final class CodableAPIClientTests: XCTestCase {
    let testCases: [AnyTestCase] = [
        TestCase(SuccessRequest(method: .delete), "https://httpbin.org/delete",        1, .init(args: .nil(), json: .init()), nil).any(),
        TestCase(SuccessRequest(method: .get),    "https://httpbin.org/get?a=c&b=d", nil, .init(args: .init(), json: nil),    nil).any(),
        TestCase(SuccessRequest(method: .patch),  "https://httpbin.org/patch",         1, .init(args: .nil(), json: .init()), nil).any(),
        TestCase(SuccessRequest(method: .post),   "https://httpbin.org/post",          1, .init(args: .nil(), json: .init()), nil).any(),
        TestCase(SuccessRequest(method: .put),    "https://httpbin.org/put",           1, .init(args: .nil(), json: .init()), nil).any(),
    ]
    
    func testExample() {
        testCases.forEach { $0.run() }
    }

    final class TestCase<APIRequestType: CallCheckableAPIRequest> {
        typealias CallCheckerType = CallChecker<APIRequestType.ResponseType, APIRequestType.APIErrorType>
        
        let request: APIRequestType
        let expected: CallCheckerType
        
        init(
            _ request: APIRequestType,
            _ expectedRequested: String?,
            _ expectedProgress: Double?,
            _ expectedSuccess: APIRequestType.ResponseType?,
            _ expectedFailure: APIRequestType.APIErrorType?
        ) {
            self.request = request
            self.expected = CallChecker(expectedRequested, expectedProgress, expectedSuccess, expectedFailure)
        }
        
        func any() -> AnyTestCase { AnyTestCase(self) }
        
        func run() {
            print(request.path)
            let semaphore = DispatchSemaphore(value: 0)
            request.runWithCallCheck { semaphore.signal() }
            semaphore.wait()
            AssertEqual(expected: expected, actual: request.callChecker, request.path)
            sleep(1)
        }
    }
    
    final class AnyTestCase {
        let run: () -> Void
        init<T: CallCheckableAPIRequest>(_ testCase: TestCase<T>) {
            run = testCase.run
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
