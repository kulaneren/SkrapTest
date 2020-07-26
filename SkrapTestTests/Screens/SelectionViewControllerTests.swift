//
//  SelectionViewControllerTests.swift
//  SkrapTestTests
//
//  Created by eren kulan on 26/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import XCTest

@testable import SkrapTest

class SelectionViewControllerTests: XCTestCase {

    var selectionViewController: SelectionViewController!
    let apiClientFake = APIClientFake()

    override func setUp() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        selectionViewController = storyBoard.instantiateViewController(identifier: "SelectionViewController") as? SelectionViewController
        selectionViewController.apiClient = apiClientFake
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = selectionViewController
        _ = selectionViewController.view
    }

    override func tearDown() {
        selectionViewController = nil
    }

    func testViewDidLoad() {
        XCTAssertEqual(selectionViewController.tableView.estimatedRowHeight, 85.0)
        XCTAssertTrue(selectionViewController.containerSubServices.isHidden)
    }

    func testGetAddressesFails() {
        apiClientFake.returnError = true
        selectionViewController.getAddresses(withAPIClient: apiClientFake)
        guard let presentedViewController = selectionViewController.presentedViewController else {
            XCTFail("presentedViewController nil")
            return
        }
        XCTAssertTrue(presentedViewController.isKind(of: UIAlertController.self))
    }

    func testGetSubServicesSucceed() {
        selectionViewController.getSubServices(withAPIClient: apiClientFake)
        selectionViewController.selectedMode = .subServices
        selectionViewController.tableView.reloadData()
        let count = selectionViewController.tableView(selectionViewController.tableView, numberOfRowsInSection: 0)
        XCTAssertTrue(count > 0)
    }

    func testGetSubServicesFails() {
        apiClientFake.returnError = true
        selectionViewController.getSubServices(withAPIClient: apiClientFake)
        guard let presentedViewController = selectionViewController.presentedViewController else {
            XCTFail("presentedViewController nil")
            return
        }
        XCTAssertTrue(presentedViewController.isKind(of: UIAlertController.self))
    }

    func testCreateAndAnimateLabel() {
        let frame = CGRect(x: 20.0, y: 280.0, width: 325, height: 30)
        let address = SAddress(postcode: "test",
                               postTown: "test",
                               buildingName: "test",
                               buildingNumber: 34,
                               country: "test")
        let expectation = self.expectation(description: "CreateAndAnimateLabel")
        selectionViewController.createAndAnimateLabel(withFrame: frame,
                                                      address: address,
                                                      completion: {
                                                        expectation.fulfill()
                                                        XCTAssertNotNil(self.selectionViewController.labelFeatured)
                                                        XCTAssertEqual(self.selectionViewController.labelFeatured.superview, self.selectionViewController.viewSelection)
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
