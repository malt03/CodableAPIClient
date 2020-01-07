//
//  APIError.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation

public struct APIError<ResponseType: Decodable>: Error {
    public private(set) var error: Error
    public private(set) var response: ResponseType?
    public private(set) var rawResponse: Data?

    init(error: Error, rawResponse: Data?, decoder: JSONDecoder) {
        self.error = error
        self.rawResponse = rawResponse
        response = rawResponse.flatMap { try? decoder.decode(ResponseType.self, from: $0) }
    }
    
    init(error: Error) {
        self.error = error
        rawResponse = nil
        response = nil
    }
}

extension APIError: LocalizedError {
  public var errorDescription: String? {
    return error.localizedDescription
  }
}
