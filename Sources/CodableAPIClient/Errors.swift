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
