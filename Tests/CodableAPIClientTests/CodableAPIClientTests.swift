import XCTest
@testable import CodableAPIClient

final class CodableAPIClientTests: XCTestCase {
    let testCases: [AnyTestCase] = [
        TestCase(DeleteRequest(parameters: .init(a: "c", b: "d")), "https://httpbin.org/delete",        1, .init(json: .init(a: "c", b: "d")), nil).any(),
        TestCase(GetRequest(parameters: .init(a: "c", b: "d")),    "https://httpbin.org/get?a=c&b=d", nil, .init(args: .init(a: "c", b: "d")), nil).any(),
        TestCase(PatchRequest(parameters: .init(a: "c", b: "d")),  "https://httpbin.org/patch",         1, .init(json: .init(a: "c", b: "d")), nil).any(),
        TestCase(PostRequest(parameters: .init(a: "c", b: "d")),   "https://httpbin.org/post",          1, .init(json: .init(a: "c", b: "d")), nil).any(),
        TestCase(PutRequest(parameters: .init(a: "c", b: "d")),    "https://httpbin.org/put",           1, .init(json: .init(a: "c", b: "d")), nil).any(),
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
