//
//  APIRequest+Extensions.swift
//  Example
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation
import CodableAPIClient

extension APIRequest {
    var baseUrl: URL { URL(string: "https://httpbin.org")! }
    var headers: [String: String] { [:] }

    func didBeginRequest(task: URLSessionUploadTask) {
        print("didBegin url:\(task.currentRequest?.url?.absoluteString ?? "")")
    }
    func didProgress(progress: Double) {
        print("didProgress \(progress)")
    }
    func didSuccess(response: ResponseType) {
        print("didSuccess \(response)")
    }
    func didFailure(error: APIError<ErrorResponse>) {
        print("didFailure \(error)")
    }

    var encoder: JSONEncoder { JSONEncoder() }
    var decoder: JSONDecoder { JSONDecoder() }
}
