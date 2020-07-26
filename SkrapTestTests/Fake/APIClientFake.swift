//
//  APIClientFake.swift
//  SkrapTestTests
//
//  Created by eren kulan on 26/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import Foundation

@testable import SkrapTest

class APIClientFake: APIClient {

    var returnError = false

    override func getServices(withCompletion completion: @escaping ([SService]?, Error?) -> Void) {
        if returnError {
            completion(nil, NSError(domain: "Error", code: 400, userInfo: nil))
        } else {
            guard let data = loadJson(filename: "getServices") else {
                completion(nil, NSError(domain: "Error", code: 400, userInfo: nil))
                return
            }
            let jsonDecoder = JSONDecoder()
            let services = try! jsonDecoder.decode(GenericJSON<SService>.self, from: data)
            completion(services.result, nil)
        }
    }

    override func getRecentAdresses(withCompletion completion: @escaping ([SAddress]?, Error?) -> Void) {
        if returnError {
            completion(nil, NSError(domain: "Error", code: 400, userInfo: nil))
        } else {
            guard let data = loadJson(filename: "getRecentAdresses") else {
                completion(nil, NSError(domain: "Error", code: 400, userInfo: nil))
                return
            }
            let jsonDecoder = JSONDecoder()
            let addresses = try! jsonDecoder.decode(GenericJSON<SAddress>.self, from: data)
            completion(addresses.result, nil)
        }
    }

    override func getSubServices(withCompletion completion: @escaping ([SSubService]?, Error?) -> Void) {
        if returnError {
            completion(nil, NSError(domain: "Error", code: 400, userInfo: nil))
        } else {
            guard let data = loadJson(filename: "getSubServices") else {
                completion(nil, NSError(domain: "Error", code: 400, userInfo: nil))
                return
            }
            let jsonDecoder = JSONDecoder()
            let subServices = try! jsonDecoder.decode(GenericJSON<SSubService>.self, from: data)
            completion(subServices.result, nil)
        }
    }

    func loadJson(filename fileName: String) -> Data? {
        let bundle = Bundle(for: APIClientFake.self)
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("loadJson error: \(error)")
            }
        }
        return nil
    }
}
