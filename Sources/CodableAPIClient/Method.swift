//
//  Method.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation

public enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
    
    var raw: String {
        switch self {
        case .get:    return "GET"
        case .post:   return "POST"
        case .put:    return "PUT"
        case .patch:  return "PATCH"
        case .delete: return "DELETE"
        }
    }
}
