//
//  MockURLSessionDataTask.swift
//  Cake ListTests
//
//  Created by Peter Murray on 30/03/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import UIKit
import Cake_List

public class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    public var state = URLSessionTask.State.suspended
    public private(set) var resumeWasCalled = false
    public private(set) var cancelWasCalled = false
    
    public init() { }
    
    public func resume() {
        state = .running
        resumeWasCalled = true
    }
    public func cancel() {
        state = .completed
        cancelWasCalled = true
    }
    
}

