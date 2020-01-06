//
//  HttpBinRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation
import CodableAPIClient

struct HttpBinRequest: APIRequest {
    var method: HTTPMethod { return .post }
    
    var path: String { return "/post" }
    
    var parameters: NoValue { return NoValue() }
    
    typealias ResponseType = NoValue
    
    typealias ParametersType = NoValue
}

struct NoValue: Codable {
    
}
