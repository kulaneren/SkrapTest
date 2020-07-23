//
//  APIClient.swift
//  SkrapTest
//
//  Created by eren kulan on 23/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import Foundation

class APIClient {

    fileprivate let jsonDecoder = JSONDecoder()
    fileprivate let defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Timeout.IntervalForRequest
        configuration.timeoutIntervalForResource = Timeout.IntervalForResource
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    var dataTask: URLSessionDataTask?

    func getServices(withCompletion completion: @escaping ([SService]?, Error?) -> Void) {
        let url = URL(string: API.URLBase + API.URLExtesionGetServices)!
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if let data = data,
                let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let convertedData = try self.jsonDecoder.decode(GenericJSON.self, from: data)
                    let services = convertedData.result
                    DispatchQueue.main.async {
                        completion(services, nil)
                    }
                } catch {
                    print("Error on decoding services : ", error)
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        dataTask?.resume()
    }
}
