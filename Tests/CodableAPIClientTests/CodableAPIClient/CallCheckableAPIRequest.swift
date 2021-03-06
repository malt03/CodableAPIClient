//
//  CallCheckableAPIRequest.swift
//  CodableAPIClientTests
//
//  Created by Koji Murata on 2020/01/09.
//

import Foundation
@testable import CodableAPIClient

final class CallChecker<ResponseType: Equatable>: Equatable, CustomStringConvertible {
    var description: String {
        """
        progressCallback: \(progressCallback.map { String(describing: $0) } ?? "nil")
        successCallback: \(successCallback.map { String(describing: $0) } ?? "nil")
        failureCallback: \(failureCallback.map { String(describing: $0) } ?? "nil")
        didBeginRequestFunc: \(didBeginRequestFunc.map { String(describing: $0) } ?? "nil")
        didProgressFunk: \(didProgressFunk.map { String(describing: $0) } ?? "nil")
        didSuccessFunk: \(didSuccessFunk.map { String(describing: $0) } ?? "nil")
        didFailureFunk: \(didFailureFunk.map { String(describing: $0) } ?? "nil")
        """
    }
    
    static func == (lhs: CallChecker<ResponseType>, rhs: CallChecker<ResponseType>) -> Bool {
        return lhs.progressCallback == rhs.progressCallback &&
            lhs.successCallback == rhs.successCallback &&
            lhs.failureCallback == rhs.failureCallback &&
            lhs.didBeginRequestFunc == rhs.didBeginRequestFunc &&
            lhs.didProgressFunk == rhs.didProgressFunk &&
            lhs.didSuccessFunk == rhs.didSuccessFunk &&
            lhs.didFailureFunk == rhs.didFailureFunk
    }
    
    var progressCallback: Double?
    var successCallback: ResponseType?
    var failureCallback: String?
    
    var didBeginRequestFunc: URL?
    var didProgressFunk: Double?
    var didSuccessFunk: ResponseType?
    var didFailureFunk: String?

    init() {}
    init(
        _ requested: String?,
        _ progress: Double?,
        _ success: ResponseType?,
        _ failure: String?
    ) {
        self.progressCallback = progress
        self.successCallback = success
        self.failureCallback = failure
        self.didBeginRequestFunc = requested.map { URL(string: $0)! }
        self.didProgressFunk = progress
        self.didSuccessFunk = success
        self.didFailureFunk = failure
    }
}

protocol CallCheckableAPIRequest: APIRequest where ResponseType: Equatable, ErrorResponseType == ErrorResponse {
    var callChecker: CallChecker<ResponseType> { get set }
}

extension CallCheckableAPIRequest {
    func didBeginRequest(task: URLSessionUploadTask) {
        callChecker.didBeginRequestFunc = task.currentRequest?.url
    }
    func didProgress(progress: Double) {
        callChecker.didProgressFunk = progress
    }
    func didSuccess(response: ResponseType, rawResponse: Data) {
        callChecker.didSuccessFunk = response
    }
    func didFailure(error: Error, response: ErrorResponseType?, rawResponse: Data?) {
        callChecker.didFailureFunk = error.localizedDescription
    }
    
    func runWithCallCheck(completion: @escaping () -> Void) {
        run(progress: {
            self.callChecker.progressCallback = $0
        }, success: {
            self.callChecker.successCallback = $0
            completion()
        }, failure: { (error, _) in
            self.callChecker.failureCallback = error.localizedDescription
            completion()
        })
    }
}
