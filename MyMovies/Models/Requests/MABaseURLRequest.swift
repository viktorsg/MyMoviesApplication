//
//  MABaseURLRequest.swift
//  MyMovies
//
//  Created by Viktor Georgiev on 3.04.18.
//  Copyright © 2018 Viktor Georgiev. All rights reserved.
//

import UIKit

class MABaseURLRequest: NSObject {
    
    
    // MARK: Variables
    
    internal var link : String
    internal var body : Data?
    internal var data : [String : Any]
    
    internal var httpCode : Int?
    internal var response : NSDictionary?
    
    
    // MARK: Initializers
    
    override init() {
        link = ""
        data = [:]
        
        super.init()
    }
    
    
    // MARK: Public Methods
    
    func send() {
        MAAplicationManager.shared.networkActivityDidStart()
        self.sendRequest(self.link, data: self.data)
    }
    
    
    // MARK: Abstract Request Methods
    
    var method: String {
        return MAHttpMethod.get
    }
    
    var additionalHeaders: [String : String] {
        return [:]
    }
    
    var successAction: Selector {
        assert(false, "Abstract method not implemented \(#function)")
        return #selector(MACommunicationDelegate.defaultSuccess)
    }
    
    var failedAction: Selector {
        assert(false, "Abstract method not implemented \(#function)")
        return #selector(MACommunicationDelegate.defaultFailure)
    }
    
    var onSuccessData: Any? {
        return nil
    }
    
    
    // MARK: Private Methods
    
    private func sendRequest(_ baseLink: String, data: [String : Any]) {
        self.link = String(format: "%@%@%@%@",
                           MAConfig.host,
                           baseLink,
                           self.apiKey,
                           self.parameters(fromDictionary: data))
        
        guard let url = URL(string: self.link) else {
            MACommunicationManager.shared.didReceiveResponseForRequest(self)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod          = self.method
        request.allHTTPHeaderFields = self.headers
        request.httpBody            = self.body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.checkResponse(response, data: data, error: error)
        }
        
        task.resume()
    }
    
    private func checkResponse(_ response: URLResponse?, data: Data?, error: Error?) {
        guard let response = response else {
            return
        }
        
        if !self.isRequestResponse(response.url?.absoluteString ?? "") {
            return
        }
        
        self.handleRequestResponse(data: data, response: response, error: error)
    }
    
    private func isRequestResponse(_ responseLink: String) -> Bool {
        return self.link == responseLink
    }
    
    private func handleRequestResponse(data: Data?, response: URLResponse?, error: Error?) {
        self.response = self.dictionary(fromData: data)
        
        if let httpResponse = response as? HTTPURLResponse {
            self.httpCode = httpResponse.statusCode
        }
        
        DispatchQueue.main.async {
            MACommunicationManager.shared.didReceiveResponseForRequest(self)
        }
    }
    
    
    // MARK: Helpers
    
    private func dictionary(fromData responseData: Data?) -> NSDictionary? {
        guard let data = responseData else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
        } catch {
            return nil
        }
    }
    
    private func parameters(fromDictionary dictionary: [String : Any]) -> String {
        let dictionary = NSDictionary.baseParametersForRequest(withExtraData: dictionary)
        
        var params = ""
        
        for (key, value) in dictionary {
            params.append("&\(key)=\(value)")
        }
        
        return params
    }
    
    private var headers: [String : String] {
        var baseHeaders = [
            "Connection"   : "keep-alive",
            "Content-Type" : "application/json;charset=utf-8"
        ]
        
        baseHeaders.appendDictionary(self.additionalHeaders)
        
        return baseHeaders
    }
    
    private var apiKey: String {
        return "?api_key=\(MAConfig.apiKey)"
    }
    

}
