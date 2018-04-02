//
//  Bakery.swift
//  Cake List
//
//  Created by Peter Murray on 28/03/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import UIKit

@objc public class Bakery: NSObject {
    
    let session: URLSessionProtocol
    
    override init() {
        session = URLSession(configuration: .default)
        super.init()
    }
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getCakes(completeion: @escaping (_ cakes: [Cake]?, _ error: Error?) -> Void) {
        let url = URL(string: "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json")
        let request = URLRequest(url: url!)
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if error != nil {
                completeion(nil, error)
            } else if data != nil {
                do {
                    let decoder = JSONDecoder()
                    let cakes = try decoder.decode([Cake].self, from: data!)
                    completeion(cakes, nil)
                } catch {
                    completeion(nil, error)
                }
            }
        }
        task.resume()
    }

}
