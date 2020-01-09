//
//  DelayRequest.swift
//  CodableAPIClientTests
//
//  Created by Koji Murata on 2020/01/09.
//

import Foundation
import CodableAPIClient

struct DelayRequest: CallCheckableAPIRequest {
    var callChecker = CallChecker<ResponseType>()

    var method: HTTPMethod { .get }
    var path: String { "/delay/\(delay)" }
    
    let delay: Int
    let timeoutInterval: TimeInterval?
    
    var parameters = NoValue()
    typealias ResponseType = NoValue
}
