# CodableAPIClient  [![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg)](https://github.com/apple/swift-package-manager) ![License](https://img.shields.io/github/license/malt03/CodableAPIClient.svg)

CodableAPIClient is an very typesafe api client library with Codable.

## Usage

### Create Request Model

```swift
struct ExampleRequest: APIRequest {
    var baseUrl: URL { URL(string: "http://example.com/")! }
    
    var method: HTTPMethod { .post }
    var path: String { "/path" }
    
    let parameters = Parameters(a: "a", b: "b")
    typealias ResponseType = Response

    var headers: [String : String] { ["Custom-Header": "xxx"] }
    var timeoutInterval: TimeInterval? { 10 }
    
    var encoder: JSONEncoder { JSONEncoder() }
    var decoder: JSONDecoder { JSONDecoder() }
    
    func didBeginRequest(task: URLSessionUploadTask) {}
    func didProgress(progress: Double) {}
    func didSuccess(response: Response, rawResponse: Data) {}
    func didFailure(error: Error, response: ErrorResponse?, rawResponse: Data?) {}

    struct Parameters: Encodable {
        let a: String
        let b: String
    }

    struct Response: Decodable {
        let c: String
        let d: String
    }
    
    struct ErrorResponse: Decodable {
        let debugMessage: String
    }
}
```

### Request

```swift
ExampleRequest().run(progress: { print($0) }, success: { response in print(response) }, failure: { error, response in print(response) })
```

### Recommended Extension

```swift
extension APIRequest {
    var baseUrl: URL { URL(string: "http://example.com")! }
    
    var headers: [String: String] {
        [
            "MyService-Session-Token": Session.shared.token ?? "",
        ]
    }
    
    var timeoutInterval: TimeInterval? { nil }

    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
    func didBeginRequest(task: URLSessionUploadTask) {
        debugPrint("beginRequest: \(path)")
    }
    func didProgress(progress: Double) {
        debugPrint("progress: \(progress) \(path)")
    }
    func didSuccess(response: ResponseType, rawResponse: Data) {
        debugPrint("success: \(String(data: rawResponse, encoding: .utf8) ?? "")")
    }
    func didFailure(error: Error, response: ErrorResponseType?, rawResponse: Data?) {
        debugPrint("failure: \(error.localizedDescription) \(rawResponse.flatMap { String(data: $0, encoding: .utf8) } ?? "")")
    }
}
```

```swift
struct ExampleRequest: APIRequest {
    var method: HTTPMethod { .post }
    var path: String { "/path" }

    let parameters = Parameters(a: "a", b: "b")
    typealias ResponseType = Response
}
```

## Installation

### [SwiftPM](https://github.com/apple/swift-package-manager)

- On Xcode, click `File` > `Swift Packages` > `Add Package Dependency...`
- Input `https://github.com/malt03/CodableAPIClient.git`

## Test
```bash
docker run -p 80:80 kennethreitz/httpbin
```

## Test
Edit the Schema for Test, set the App Language in Options to English, and run tests.
