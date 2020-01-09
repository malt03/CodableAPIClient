//
//  CustomHeaderRequest.swift
//  CodableAPIClientTests
//
//  Created by Koji Murata on 2020/01/09.
//

import CodableAPIClient

struct CustomHeaderRequest: CallCheckableAPIRequest {
    var callChecker = CallChecker<ResponseType>()

    var method: HTTPMethod { .get }
    var path: String { "/get" }
    
    var headers: [String : String] {
        [
            "Custom-Header-1": "xxxxx",
            "Custom-Header-2": "yyyyy",
        ]
    }
    
    var parameters = NoValue()
    typealias ResponseType = Response
    
    struct Response: Decodable, Equatable {
        let headers: Headers
        
        struct Headers: Decodable, Equatable {
            let accept: String
            let contentType: String
            let customHeader1: String
            let customHeader2: String
            
            enum CodingKeys: String, CodingKey {
                case accept = "Accept"
                case contentType = "Content-Type"
                case customHeader1 = "Custom-Header-1"
                case customHeader2 = "Custom-Header-2"
            }
        }
    }
}

