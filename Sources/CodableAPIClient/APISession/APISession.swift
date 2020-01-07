//
//  APISession.swift
//  CodableAPIClient
//
//  Created by Koji Murata on 2020/01/07.
//

import Foundation

final class APISession {
    typealias ProgressHandler = (Double) -> Void
    typealias SuccessHandler = (HTTPURLResponse, Data?) -> Void
    typealias FailureHandler = (Error, Data?) -> Void
    
    static let shared = APISession()
    
    private let session: URLSession
    private let sessionDelegate: SessionDelegate
    
    init() {
        sessionDelegate = SessionDelegate()
        session = URLSession(configuration: .ephemeral, delegate: sessionDelegate, delegateQueue: .main)
    }
    
    private var delegateConnectors = [URLSessionTask: DelegateConnector]()
    private let lock = NSLock()
    func upload(
        request: URLRequest,
        data: Data,
        progress: @escaping ProgressHandler,
        success: @escaping SuccessHandler,
        failure: @escaping FailureHandler
    ) -> URLSessionUploadTask {
        lock.lock()
        defer { lock.unlock() }
        
        let task = session.uploadTask(with: request, from: data)
        delegateConnectors[task] = DelegateConnector(progress: progress, success: success, failure: failure)
        task.resume()
        
        return task
    }
    
    struct DelegateConnector {
        let progress: ProgressHandler
        private let success: SuccessHandler
        private let failure: FailureHandler
        
        init(
            progress: @escaping ProgressHandler,
            success: @escaping SuccessHandler,
            failure: @escaping FailureHandler
        ) {
            self.progress = progress
            self.success = success
            self.failure = failure
        }
        
        private var receivedData: Data? = nil
        
        mutating func appendData(_ data: Data) {
            if receivedData == nil {
                receivedData = data
            } else {
                receivedData?.append(data)
            }
        }

        func complete(_ task: URLSessionTask) {
            if let error = task.error {
                failure(error, receivedData)
                return
            }
            guard let response = task.response as? HTTPURLResponse else {
                failure(Errors.unexpected, receivedData)
                return
            }
            success(response, receivedData)
        }
    }
    
    fileprivate func receiveData(_ data: Data, for task: URLSessionTask) {
        lock.lock()
        defer { lock.unlock() }
        delegateConnectors[task]?.appendData(data)
    }
    
    fileprivate func progress(_ progress: Double, for task: URLSessionTask) {
        lock.lock()
        defer { lock.unlock() }
        delegateConnectors[task]?.progress(progress)
    }
    
    fileprivate func complete(for task: URLSessionTask) {
        lock.lock()
        defer { lock.unlock() }
        delegateConnectors[task]?.complete(task)
        delegateConnectors[task] = nil
    }

    private final class SessionDelegate: NSObject, URLSessionDataDelegate {
        func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
            APISession.shared.progress(Double(totalBytesSent) / Double(totalBytesExpectedToSend), for: task)
        }

        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            APISession.shared.complete(for: task)
        }
        
        func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
            APISession.shared.receiveData(data, for: dataTask)
        }
    }
}
