//
//  APIRequest.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation

public protocol APIRequest {
    associatedtype ResponseType: Decodable
    associatedtype ParametersType: Encodable

    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: ParametersType { get }


    associatedtype ErrorResponseType: Decodable

    var baseUrl: URL { get }
    var headers: [String: String] { get }
    var timeoutInterval: TimeInterval? { get }

    func didBeginRequest(task: URLSessionUploadTask)
    func didProgress(progress: Double)
    func didSuccess(response: ResponseType, rawResponse: Data)
    func didFailure(error: Error, response: ErrorResponseType?, rawResponse: Data?)
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}
