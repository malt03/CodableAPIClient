//
//  APIRequest+Extensions.swift
//  Example
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation
import CodableAPIClient

extension APIRequest {
    var baseUrl: URL { URL(string: "http://localhost")! }
    var headers: [String: String] { [:] }
    
    var timeoutInterval: TimeInterval? { nil }

    var encoder: JSONEncoder { JSONEncoder() }
    var decoder: JSONDecoder { JSONDecoder() }
}
