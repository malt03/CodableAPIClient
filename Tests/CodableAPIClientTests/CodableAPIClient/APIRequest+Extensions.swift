//
//  APIRequest+Extensions.swift
//  Example
//
//  Created by Koji Murata on 2020/01/06.
//

import Foundation
import CodableAPIClient

extension APIRequest {
    var baseUrl: URL { URL(string: "https://httpbin.org")! }
    var headers: [String: String] { [:] }

    var encoder: JSONEncoder { JSONEncoder() }
    var decoder: JSONDecoder { JSONDecoder() }
}
