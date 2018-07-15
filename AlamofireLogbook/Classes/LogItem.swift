//
//  LogItem.swift
//  AlamofireLogbook
//
//  Created by Michael Attia on 6/1/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import Foundation
import Alamofire

public struct LogItem: CustomStringConvertible{
    enum ResponseStatus{
        case success, serverFailure, failure
    }
    public let request: String
    let requestDomain: String
    let requestMethod: String
    let requestURL: String
    let requestQueryParams : [String]
    public let requestHeaders: [String : String]
    let requestBody: Data?
    public var requestLoad: String?{
        guard let reqBody = requestBody,
            let payload = String(data: reqBody, encoding: .utf8) else {
            return nil
        }
        return payload
    }
    
    let requestTime: String
    let requestDuration: String
    
    public let responseStatusCode: String
    let responseStatus: ResponseStatus
    public let responseHeaders: [String : String]
    let responseBody: Data?
    public var responseLoad: String?{
        guard let resBody = responseBody,
            let body = String(data: resBody, encoding: .utf8) else{
                return nil
        }
        return body
    }
    
    public var description: String{
        var str = "[REQUEST] : \n \(self.requestMethod.uppercased()): \(self.request)\n"
        
        if let reqHeadersData = try? JSONSerialization.data(withJSONObject: requestHeaders, options: .prettyPrinted), let reqHeaders = String(data: reqHeadersData, encoding: .utf8){
            str.append("[REQUEST HEADERS] : \n \(reqHeaders)\n")
        }
        
        if let reqBody = requestBody,
            let body = String(data: reqBody, encoding: .utf8){
            str.append("[REQUEST BODY] : \n \(body)\n")
        }
        
        if let resBody = responseBody,
            let body = String(data: resBody, encoding: .utf8){
            str.append("[RESPONSE] : \n [RESULT: \(responseStatusCode)]  \n\(body)\n")
        }
        return str.replacingOccurrences(of: "\\/", with: "/")
    }
    
    init(response: DataResponse<Data>){
        self.request = response.request?.url?.absoluteString ?? ""
        self.requestDomain = response.request?.url?.host ?? ""
        self.requestMethod = response.request?.httpMethod ?? ""
        self.requestURL = response.request?.url?.path ?? ""
        self.requestQueryParams = response.request?.url?.query?.components(separatedBy: "&").filter{!$0.isEmpty} ?? []
        self.requestHeaders = response.request?.allHTTPHeaderFields ?? [:]
        
        if let requestBody = response.request?.httpBody{
            if let json = try? JSONSerialization.jsonObject(with: requestBody, options: .allowFragments){
                let prettyPrintedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                self.requestBody = prettyPrintedData
            }else{
                self.requestBody = requestBody
            }
        }else{
            self.requestBody = nil
        }
        
        let startTime = response.timeline.requestStartTime
        self.requestTime = Date(timeIntervalSince1970: startTime).toString(format: "hh:mm:ss")
        self.requestDuration = String(format: "%.2f second", response.timeline.requestDuration)
        
        if let serverResponse = response.response{
            self.responseStatus = (200..<300).contains(serverResponse.statusCode) ? .success : .serverFailure
            self.responseStatusCode = String(serverResponse.statusCode)
            self.responseHeaders = (serverResponse.allHeaderFields as? [String: String]) ?? [:]
            if let responseBody = response.data{
                if let json = try? JSONSerialization.jsonObject(with: responseBody, options: .allowFragments){
                    let prettyPrintedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    self.responseBody = prettyPrintedData
                }else{
                    self.responseBody = responseBody
                }
            }else{
                self.responseBody = nil
            }
        }else{
            self.responseStatus = .failure
            self.responseStatusCode = (response.error as? URLError)?.localizedDescription ?? ""
            self.responseHeaders = [:]
            self.responseBody = nil
        }
    }
}





