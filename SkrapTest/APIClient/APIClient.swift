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
        let url = URL(string: API.URLAPIBase + API.URLExtesionGetServices)!
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if let data = data,
                let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let convertedData = try self.jsonDecoder.decode(GenericJSON<SService>.self, from: data)
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

    func getRecentAdresses(withCompletion completion: @escaping ([SAddress]?, Error?) -> Void) {
        let parameters = [
            [
                "key": "limit",
                "value": "0",
                "type": "text"
            ],
            [
                "key": "user_id",
                "value": "1170",
                "type": "text"
            ]] as [[String : Any]]

        let url = API.URLAPIBase + API.URLExtensionGetRecentAddresses

        dataTask = defaultSession.dataTask(with: createRequest(parameters: parameters, url: url)) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if let data = data,
                let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let convertedData = try self.jsonDecoder.decode(GenericJSON<SAddress>.self, from: data)
                    let addresses = convertedData.result
                    DispatchQueue.main.async {
                        completion(addresses, nil)
                    }
                } catch {
                    print("Error on decoding addresses : ", error)
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        dataTask?.resume()
    }

    func getSubServices(withCompletion completion: @escaping ([SSubService]?, Error?) -> Void) {
        let parameters = [
            [
                "key": "post_code",
                "value": "E11 1ER",
                "type": "text"
            ],
            [
                "key": "service_type",
                "value": "2",
                "type": "text"
            ]] as [[String : Any]]

        let url = API.URLAPIBase + API.URLExtensionGetSubServices

        dataTask = defaultSession.dataTask(with: createRequest(parameters: parameters, url: url)) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if let data = data,
                let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let convertedData = try self.jsonDecoder.decode(GenericJSON<SSubService>.self, from: data)
                    let subServices = convertedData.result
                    DispatchQueue.main.async {
                        completion(subServices, nil)
                    }
                } catch {
                    print("Error on decoding subServices : ", error)
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        dataTask?.resume()
    }

    func createRequest(parameters: [[String : Any]], url: String) -> URLRequest{
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"]!
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                let paramType = param["type"] as! String
                if paramType == "text" {
                    let paramValue = param["value"] as! String
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] as! String
                    //                    let fileData: Data
                    do {let fileData = try NSData(contentsOfFile:paramSrc, options:[]) as Data
                        let fileContent = String(data: fileData, encoding: .utf8)!
                        body += "; filename=\"\(paramSrc)\"\r\n"
                            + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
                    }catch{
                        print("")
                    }

                }
            }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)

        request.addValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImE2NDM2YjMzMzEwNzQxMmM1OTYzMDA1M2Y1OWNlMmRlMjM3NDVkYzMzZjgwMTY4NTc5YjllODQ3Zjc2MzFiYjM3MDBiMTY3OGUxMDJmNDNhIn0.eyJhdWQiOiIzIiwianRpIjoiYTY0MzZiMzMzMTA3NDEyYzU5NjMwMDUzZjU5Y2UyZGUyMzc0NWRjMzNmODAxNjg1NzliOWU4NDdmNzYzMWJiMzcwMGIxNjc4ZTEwMmY0M2EiLCJpYXQiOjE1OTQ4ODkzNDUsIm5iZiI6MTU5NDg4OTM0NSwiZXhwIjoxNjI2NDI1MzQ1LCJzdWIiOiIyNTgxIiwic2NvcGVzIjpbXX0.hcu3rpiueU07bASDoj-A-csf2EG-I4ZxAGcuk_llEUktyb9k_B8UEN2Jw72jdNi-N5zz1NmlZoFvwmkh_kSw7W-f2H-CTGDMM5_b7yw9w-VRkx0yrOLe_2vUCGU22-DDK5TdEYGfkKpJubKs2Z8-p6JYC74y0b_4q6eZWx_lADVXj54CeJv_vXHPetoxZKsiF4f-JCECWLxAZrHu6X9N116nPVSpnSNXJufQfvRKN6Z-YABSzXD-yHGuU9-mga3Ac7L-UIagLUlFLHdJg0UJfXHIyuhIPrbqN0mmXL1694fYX6wsr68MsnhLOmcuQL98WLlJeS2cwz0YPB21Ys94rQYgiKSIC7eEg_rqcFPI826SqO86OjmcL79u8YVLPHJhZzP4KuobpxUBZ6HghsQ9Y9MUpssGw23KlkaJRXz4-rB9F6pbP69-gOGL9_vOHBJSMY5-q7X8_t4XEAmFqUWogZaQJ-F7fAB0q_7JlkqnBTDFER9o_vGq5ZobIM6Z7YyTYd5M6a9u5-17JjSguGKZzYhwhrWXHAHYsWa17bk5dWSYkAMB22ovgNpS9TS6vjUd0NNemhnWzxEu78CvZceFbs52-Um7shhlPJT0T2whajE24rfYxACBtUhnqJiDLIu8mPR9tPQslJHqAcvubE1If3ARVon3WL4e7RMufyvBahk", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData
        return request
    }
}
