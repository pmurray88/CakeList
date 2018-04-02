//
//  TestUtils.swift
//  Cake ListTests
//
//  Created by Peter Murray on 31/03/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import Foundation

class TestUtils {
    
    class func dataWith(name: String) -> Data {
        var responseData = Data()
        if let bundle = Bundle(identifier: "com.waracle.Cake-ListTests"),
            let path = bundle.path(forResource: name, ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                responseData = jsonData as Data
            }
        }
        return responseData
    }
}
