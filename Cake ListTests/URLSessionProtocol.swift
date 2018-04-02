//
//  URLSessionProtocol.swift
//  Cake ListTests
//
//  Created by Peter Murray on 29/03/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import Foundation

typealias DataTaskResultHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithRequest(_ request: URLRequest, completionHandler: @escaping DataTaskResultHandler) -> URLSessionDataTaskProtocol
}

public protocol URLSessionDataTaskProtocol {
    var state: URLSessionTask.State { get }
    func resume()
    func cancel()
}

extension URLSession: URLSessionProtocol {
    func dataTaskWithRequest(_ request: URLRequest, completionHandler:  @escaping DataTaskResultHandler)
        -> URLSessionDataTaskProtocol
    {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
