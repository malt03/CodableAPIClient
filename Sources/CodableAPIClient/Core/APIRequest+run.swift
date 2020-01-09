//
//  APIRequest+run.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation
import URLQueryItemsCoder

extension APIRequest {
    private func createUploadURL() throws -> URL {
        let url = baseUrl.appendingPathComponent(path)
        
        if method != .get { return url }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = try URLQueryItemsEncoder().encode(parameters)
        if queryItems.isEmpty { return url }
        
        components.queryItems = queryItems
        return components.url!
    }
    private func createRequest() throws -> URLRequest {
        var request = URLRequest(url: try createUploadURL())
        if let timeoutInterval = timeoutInterval { request.timeoutInterval = timeoutInterval }

        request.httpMethod = method.raw
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        for (field, value) in headers {
            request.setValue(value, forHTTPHeaderField: field)
        }
        
        return request
    }
    private func createUploadData(with encoder: JSONEncoder) throws -> Data {
        if method == .get { return Data(count: 0) }
        return try encoder.encode(parameters)
    }
    
    @discardableResult
    public func run(
        progress: ((Double) -> Void)? = nil,
        success: ((ResponseType) -> Void)? = nil,
        failure: ((APIErrorType) -> Void)? = nil
    ) -> URLSessionUploadTask? {
        func progressWrapper(_ p: Double) {
            progress?(p)
            self.didProgress(progress: p)
        }
        func successWrapper(_ r: ResponseType, _ d: Data) {
            success?(r)
            self.didSuccess(response: r, rawResponse: d)
        }
        func failureWrapper(_ e: APIErrorType) {
            failure?(e)
            self.didFailure(error: e)
        }
         
        
        let request: URLRequest
        let uploadData: Data
        do {
            request = try createRequest()
            uploadData = try createUploadData(with: encoder)
        } catch {
            failureWrapper(APIErrorType(error: error))
            return nil
        }
        
        let task = APISession.shared.upload(
            request: request,
            data: uploadData,
            progress: { progress in
                progressWrapper(progress)
            },
            success: { response, responseData in
                if response.mimeType != "application/json" {
                    failureWrapper(APIErrorType(error: Errors.unexpectedMimeType(response.mimeType), rawResponse: responseData, decoder: self.decoder))
                    return
                }
                
                guard let responseData = responseData else {
                    failureWrapper(APIErrorType(error: Errors.emptyResponse))
                    return
                }
                
                do {
                    let response = try self.decoder.decode(ResponseType.self, from: responseData)
                    successWrapper(response, responseData)
                } catch {
                    failureWrapper(APIErrorType(error: error, rawResponse: responseData, decoder: self.decoder))
                    return
                }
            },
            failure: { error, data in
                failureWrapper(APIErrorType(error: error, rawResponse: data, decoder: self.decoder))
            })

        didBeginRequest(task: task)
     
        return task
    }
}
