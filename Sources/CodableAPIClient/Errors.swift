//
//  Errors.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation

enum Errors: Error {
    case unexpectedMimeType(String?)
    case emptyResponse
    case unexpected
}

extension Errors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unexpectedMimeType(let mimeType):
            return "Unexpected Mime Type: \(mimeType ?? "nil")"
        case .emptyResponse:
            return "CodableAPIClient Error: Empty Response"
        case .unexpected:
            return "CodableAPIClient Error: Unexpected Error"
        }
    }
}
