//
//  DeleteRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/07.
//

import CodableAPIClient

struct DeleteRequest: APIRequest {
    var method: HTTPMethod { .delete }
    var path: String { "/delete" }
    
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
