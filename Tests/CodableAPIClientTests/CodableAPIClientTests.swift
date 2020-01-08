import XCTest
@testable import CodableAPIClient

final class CodableAPIClientTests: XCTestCase {
    func testExample() {
        let semaphore = DispatchSemaphore(value: 0)
        DeleteRequest().run(progress: { (p) in
            print(p)
        }, success: { (r) in
            print(r)
            semaphore.signal()
        }, failure: { (e) in
            print(e)
            semaphore.signal()
        })
        semaphore.wait()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
