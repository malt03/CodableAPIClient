//
//  APIRequest.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation

public protocol APIRequest {
    associatedtype ResponseType: Decodable
    associatedtype QueryParametersType: Encodable
    associatedtype BodyParametersType: Encodable

    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: QueryParametersType { get }
    var bodyParameters: BodyParametersType { get }


    associatedtype ErrorResponseType: Decodable
    typealias APIErrorType = APIError<ErrorResponseType>

    var baseUrl: URL { get }
    var headers: [String: String] { get }

    func didBeginRequest(task: URLSessionUploadTask)
    func didProgress(progress: Double)
    func didSuccess(response: ResponseType)
    func didFailure(error: APIErrorType)
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}

extension APIRequest {
    public var queryParameters: NoValue { NoValue() }
    public var bodyParameters: NoValue { NoValue() }
}
