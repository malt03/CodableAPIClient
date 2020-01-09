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
        failure: ((Error, ErrorResponseType?) -> Void)? = nil
    ) -> URLSessionUploadTask? {
        func progressWrapper(_ p: Double) {
            progress?(p)
            self.didProgress(progress: p)
        }
        func successWrapper(_ r: ResponseType, _ d: Data) {
            success?(r)
            self.didSuccess(response: r, rawResponse: d)
        }
        func failureWrapper(_ e: Error, _ d: Data?) {
            let r = d.flatMap { try? decoder.decode(ErrorResponseType.self, from: $0) }
            failure?(e, r)
            self.didFailure(error: e, response: r, rawResponse: d)
        }
         
        
        let request: URLRequest
        let uploadData: Data
        do {
            request = try createRequest()
            uploadData = try createUploadData(with: encoder)
        } catch {
            failureWrapper(error, nil)
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
                    failureWrapper(Errors.unexpectedMimeType(response.mimeType), responseData)
                    return
                }
                
                guard let responseData = responseData else {
                    failureWrapper(Errors.emptyResponse, nil)
                    return
                }
                
                do {
                    let response = try self.decoder.decode(ResponseType.self, from: responseData)
                    successWrapper(response, responseData)
                } catch {
                    failureWrapper(error, responseData)
                    return
                }
            },
            failure: { error, responseData in
                failureWrapper(error, responseData)
            })

        didBeginRequest(task: task)
     
        return task
    }
}
