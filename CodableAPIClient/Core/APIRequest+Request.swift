//
//  APIRequest+Request.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation

extension APIRequest {
    var uploadURL: URL { baseUrl.appendingPathComponent(path) }
    func createRequest() -> URLRequest {
        var request = URLRequest(url: uploadURL)
        
        request.httpMethod = method.raw
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (field, value) in headers {
            request.setValue(value, forHTTPHeaderField: field)
        }
        
        return request
    }
    
    public func run(
        progress: ((Progress) -> Void)? = nil,
        success: ((ResponseType) -> Void)? = nil,
        failure: ((APIErrorType) -> Void)? = nil
    ) {
        func progressWrapper(_ p: Progress) {
            progress?(p)
            self.didProgress(progress: p)
        }
        func successWrapper(_ r: ResponseType) {
            success?(r)
            self.didSuccess(response: r)
        }
        func failureWrapper(_ e: APIErrorType) {
            failure?(e)
            self.didFailure(error: e)
        }
         
        
        let request = createRequest()
        let uploadData: Data
        do {
            uploadData = try encoder.encode(parameters)
        } catch {
            failureWrapper(APIErrorType(error: error))
            return
        }
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { responseData, response, error in
            if let error = error {
                failureWrapper(APIErrorType(error: error, rawResponse: responseData, decoder: self.decoder))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                failureWrapper(APIErrorType(error: Errors.unexpected))
                return
            }
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
                successWrapper(response)
            } catch {
                failureWrapper(APIErrorType(error: error, rawResponse: responseData, decoder: self.decoder))
                return
            }
        }
        didBeginRequest(task: task)
    }
}
