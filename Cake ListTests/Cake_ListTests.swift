//
//  Cake_ListTests.swift
//  Cake ListTests
//
//  Created by Peter Murray on 28/03/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import XCTest
@testable import Cake_List

class Cake_ListTests: XCTestCase {
    
    let session = MockURLSession()
    var sut: CakeListViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "cakeListVC") as! CakeListViewController
        _ = sut.view
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func test_SUT_respondsToTableDelegate() {
        XCTAssertTrue(sut!.conforms(to: UITableViewDelegate.self))
    }
    
    func test_GetCakes() {
        
        // Mock the get cakes call providing the sample json file as a response
        self.session.nextData = TestUtils.dataWith(name: "cakes")
        let bakery = Bakery(session: self.session)
        
        let cakesExpectation = expectation(description: "gotCakes")
        bakery.getCakes { (responseCakes, error) in
            XCTAssertNotNil(responseCakes)
            if responseCakes != nil {
                XCTAssertEqual(responseCakes!.count, 20)
                cakesExpectation.fulfill()
            }
        }
        
        wait(for: [cakesExpectation], timeout: 1.0)
    }
    
//    func test_CakeCell() {
//
//        // Mock the get cakes call providing the sample json file as a response
//        self.session.nextData = TestUtils.dataWith(name: "cakes")
//        let bakery = Bakery(session: self.session)
//
//        let cakesExpectation = expectation(description: "gotCakes")
//        bakery.getCakes { (responseCakes, error) in
//            XCTAssertNotNil(responseCakes)
//            if responseCakes != nil {
////                sut.cakes = responseCakes!
////                XCTAssertEqual(cakes.count, 20)
//                cakesExpectation.fulfill()
//            }
//        }
//
//        wait(for: [cakesExpectation], timeout: 1.0)
//    }
    
    func test_CakeCell() {
        
        let cellExpectation = expectation(description: "cellExpectation")
        
        // Ideally this test shoud also have a mocked response, as letting it hit the network means
        // should the response json change as it would in a real world application then this test will fail.
        // Further investigaton is required into why Using the Swift Cake Class in the CakeListVC ObjC header
        // would not compile whilst running under Test Conditions to allow for injecting the response of a mocked call
        sut.getData { (success, error) in
            if success {
                DispatchQueue.main.async {
                    // Check it has the correct # of cells
                    XCTAssertEqual(self.sut.tableView.numberOfRows(inSection: 0), 20)
                    
                    // Get the first cell and check its displaying the correct information (ie not the storyboard defaults)
                    let cell = self.sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CakeCell
                    XCTAssertNotNil(cell)
                    XCTAssertNotEqual(cell?.titleLabel.text, "Label")
                    XCTAssertNotEqual(cell?.descriptionLabel.text, "Label")
                }
                
            } else {
                DispatchQueue.main.async {
                    XCTAssertEqual(self.sut.tableView.numberOfRows(inSection: 0), 0)
                }
            }
            cellExpectation.fulfill()
        }
        
        wait(for: [cellExpectation], timeout: 5.0)
    }
    
    func test_GetCakes_InvalidJSON() {
        
        // Mock the get cakes call with an invalid response
        self.session.nextData = TestUtils.dataWith(name: "invalid")
        let bakery = Bakery(session: self.session)
        let cakesExpectation = expectation(description: "gotCakesFailed")
        bakery.getCakes { (responseCakes, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(responseCakes)
            cakesExpectation.fulfill()
        }
        
        wait(for: [cakesExpectation], timeout: 1.0)
    }
    
    func test_GetCakes_NetworkError() {
        
        // Mock the get cakes call with a network error response
        self.session.nextError = NSError(domain: "com.waracle.error", code: 500, userInfo: nil)
        let bakery = Bakery(session: self.session)
        let cakesExpectation = expectation(description: "gotCakesFailed")
        bakery.getCakes { (responseCakes, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(responseCakes)
            cakesExpectation.fulfill()
        }
        
        wait(for: [cakesExpectation], timeout: 1.0)
    }
    

    
}
