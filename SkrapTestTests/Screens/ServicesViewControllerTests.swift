//
//  ServicesViewController.swift
//  SkrapTestTests
//
//  Created by eren kulan on 25/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import XCTest

@testable import SkrapTest

class ServicesViewControllerTest: XCTestCase {

    var servicesViewController: ServicesViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        servicesViewController = storyboard.instantiateViewController(withIdentifier: "ServicesViewController") as? ServicesViewController
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = servicesViewController
        _ = servicesViewController.view
    }

    override func tearDown() {
        servicesViewController = nil
    }

    func testViewDidLoad() {
        XCTAssertNotNil(servicesViewController.collectionServices)
        XCTAssertNotNil(servicesViewController.title, "Services")
    }

    func testGetServicesSucceed() {
        let apiClientFake = APIClientFake()
        servicesViewController.getServices(withAPIClient: apiClientFake)
        let count = servicesViewController.collectionServices.numberOfItems(inSection: 0)
        XCTAssertEqual(count, 7)
    }

    func testGetServicesFailed() {
        let apiClientFake = APIClientFake()
        apiClientFake.returnError = true
        servicesViewController.getServices(withAPIClient: apiClientFake)
        let count = servicesViewController.collectionServices.numberOfItems(inSection: 0)
        XCTAssertEqual(count, 0)
    }

    func testDidSelectItemAtIndexPath() {
        let apiClientFake = APIClientFake()
        servicesViewController.getServices(withAPIClient: apiClientFake)
        servicesViewController.collectionView(servicesViewController.collectionServices, didSelectItemAt: IndexPath(row: 0, section: 0))
        guard let presentedViewController = servicesViewController.presentedViewController else {
            XCTFail("presentedViewController is nil")
            return
        }
        XCTAssertTrue(presentedViewController.isKind(of: SelectionViewController.self))
    }
}
