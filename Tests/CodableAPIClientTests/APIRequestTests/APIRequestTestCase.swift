//
//  APIRequestTestCase.swift
//  CodableAPIClientTests
//
//  Created by Koji Murata on 2020/01/09.
//

import Foundation

final class APIRequestTestCase<APIRequestType: CallCheckableAPIRequest>: Runnable {
    typealias CallCheckerType = CallChecker<APIRequestType.ResponseType>
    
    let title: String
    let request: APIRequestType
    let expected: CallCheckerType
    
    init(
        _ title: String,
        _ request: APIRequestType,
        _ expectedRequested: String?,
        _ expectedProgress: Double?,
        _ expectedSuccess: APIRequestType.ResponseType?,
        _ expectedFailure: String?
    ) {
        self.title = title + " " + request.path
        self.request = request
        self.expected = CallChecker(expectedRequested, expectedProgress, expectedSuccess, expectedFailure)
    }
    
    func run() {
        print(title)
        let semaphore = DispatchSemaphore(value: 0)
        request.runWithCallCheck { semaphore.signal() }
        semaphore.wait()
        
        usleep(100) // wait callding didxxx
        AssertEqual(expected: expected, actual: request.callChecker, title)
    }
}
