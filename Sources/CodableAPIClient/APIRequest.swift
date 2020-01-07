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
    typealias APIErrorType = APIError<ErrorResponseType>

    var baseUrl: URL { get }
    var headers: [String: String] { get }

    func didBeginRequest(task: URLSessionUploadTask)
    func didProgress(progress: Progress)
    func didSuccess(response: ResponseType)
    func didFailure(error: APIErrorType)
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}
