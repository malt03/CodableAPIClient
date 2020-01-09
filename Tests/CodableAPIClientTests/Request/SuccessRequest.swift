//
//  SuccessRequest.swift
//  Example
//
//  Created by Koji Murata on 2020/01/07.
//

import CodableAPIClient

struct SuccessRequest: CallCheckableAPIRequest {
    var callChecker = CallChecker<Response, APIError<ErrorResponseType>>()

    var method: HTTPMethod
    var path: String { method.path }
    
    let parameters = Parameters()
    
    typealias ResponseType = Response

    struct Parameters: Equatable, Codable {
        let a: String?
        let b: String?
        
        static func `nil`() -> Parameters {
            Parameters(a: nil, b: nil)
        }
        
        init(a: String? = "c", b: String? = "d") {
            self.a = a
            self.b = b
        }
    }

    struct Response: Equatable, Decodable {
        let args: Parameters?
        let json: Parameters?
        init(args: Parameters? = nil, json: Parameters? = nil) {
            self.args = args
            self.json = json
        }
    }
}

extension HTTPMethod {
    fileprivate var path: String {
        switch self {
        case .delete: return "/delete"
        case .get:    return "/get"
        case .patch:  return "/patch"
        case .post:   return "/post"
        case .put:    return "/put"
        }
    }
}
