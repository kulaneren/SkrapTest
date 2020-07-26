//
//  APIClientTests.swift
//  SkrapTestTests
//
//  Created by eren kulan on 25/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import SkrapTest

class APIClientTests: XCTestCase {

    let apiClient = APIClient()

    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    func testGetServicesSucceed() {
        stub(condition: isMethodGET()) { _ in
            let stubPath = OHPathForFile("getServices.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        let expectation = self.expectation(description: "GetServices")
        apiClient.getServices { services, error in
            XCTAssertEqual(services?.count, 7)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetServicesFails() {
        stub(condition: isMethodGET()) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo: nil)
            return OHHTTPStubsResponse(error: notConnectedError)
        }

        let expectation = self.expectation(description: "GetServices")
        apiClient.getServices { services, error in
            XCTAssertNil(services)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetRecentAdressesSucceed() {
        stub(condition: isMethodPOST()) { _ in
            let stubPath = OHPathForFile("getRecentAdresses.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        let expectation = self.expectation(description: "GetRecentAdresses")
        apiClient.getRecentAdresses { addresses, error in
            XCTAssertEqual(addresses?.count, 1)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetRecentAdressesFails() {
        stub(condition: isMethodPOST()) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo: nil)
            return OHHTTPStubsResponse(error: notConnectedError)
        }

        let expectation = self.expectation(description: "GetRecentAdresses")
        apiClient.getRecentAdresses { addresses, error in
            XCTAssertNil(addresses)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetSubServicesSucceed() {
        stub(condition: isMethodPOST()) { _ in
            let stubPath = OHPathForFile("getSubServices.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        let expectation = self.expectation(description: "GetSubServices")
        apiClient.getSubServices { services, error in
            XCTAssertEqual(services?.count, 4)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetSubServicesFails() {
        stub(condition: isMethodPOST()) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo: nil)
            return OHHTTPStubsResponse(error: notConnectedError)
        }

        let expectation = self.expectation(description: "GetSubServices")
        apiClient.getSubServices { services, error in
            XCTAssertNil(services)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
