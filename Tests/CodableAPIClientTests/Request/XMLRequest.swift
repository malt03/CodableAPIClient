//
//  XMLRequest.swift
//  CodableAPIClientTests
//
//  Created by Koji Murata on 2020/01/09.
//

import CodableAPIClient

struct XMLRequest: CallCheckableAPIRequest {
    var callChecker = CallChecker<ResponseType>()

    var method: HTTPMethod { .get }
    var path: String { "/xml" }
    
    var parameters = NoValue()
    typealias ResponseType = NoValue
}

