//
//  PatchRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/07.
//

import CodableAPIClient

struct PatchRequest: APIRequest {
    var method: HTTPMethod { .patch }
    var path: String { "/patch" }
    
    var bodyParameters: Parameters { Parameters(a: "foo", b: "bar") }
    
    typealias ResponseType = Response

    struct Parameters: Codable {
        let a: String
        let b: String
    }

    struct Response: Decodable {
        let json: Parameters
    }
}
