//
//  MockURLSession.swift
//  Cake ListTests
//
//  Created by Peter Murray on 29/03/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import UIKit
@testable import Cake_List

class MockURLSession: URLSessionProtocol {
    
    var nextData: Data = "{}".data(using: String.Encoding.utf8)! // Default to empty json object
    var nextError: NSError?
    var nextResponse: HTTPURLResponse = HTTPURLResponse(statusCode: 200)! //Default to successful response
    
    var nextDataTask = MockURLSessionDataTask()
    private(set) var lastRequest: NSURLRequest?
    
    init() {}
    
    func dataTaskWithRequest(_ request: URLRequest, completionHandler: @escaping DataTaskResultHandler) -> URLSessionDataTaskProtocol {

        lastRequest = request as NSURLRequest?

        completionHandler(nextData as Data, nextResponse, nextError)

        return nextDataTask
    }
}

extension HTTPURLResponse {
    public convenience init?(statusCode: Int) {
        self.init(url: NSURL() as URL, statusCode: statusCode,
                  httpVersion: nil, headerFields: nil)
    }
}
