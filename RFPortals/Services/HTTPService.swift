//
//  HTTPService.swift
//  RFPortals
//
//  Created by goliatone on 12/8/18.
//  Copyright © 2018 goliatone. All rights reserved.
//

import Foundation

class HTTPService {
    static var shared = HTTPService()
    
    func requestAccessToPortalById(openRequest: OpenPortalRequest, completion: ((Error?)-> Void)?) {
        guard let url = Configuration.serviceURL else {
            fatalError("Could not create URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "applicatoin/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(openRequest)
            print("json data", String(data:request.httpBody!, encoding: .utf8) ?? "empty")
        } catch {
            completion?(error)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError)
                return
            }
            
            if let data = responseData, let result = String(data: data, encoding: .utf8) {
                print("response: ", result)
            } else {
                print("response: empty")
            }
        }
        
        task.resume()
    }
}
