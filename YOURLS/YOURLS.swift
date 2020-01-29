//
//  YOURLS.swift
//  YOURLS
//
//  Created by Jon Lara Trigo on 29/01/2020.
//  Copyright © 2020 Jon Lara Trigo. All rights reserved.
//
import Foundation

public class YOURLS {
    private let domain: String
    private let signature: String
    private let cusConfig: cusConf
    
    public init(domain: String, signature: String, cusConfig: Dictionary<String, Any>) throws {
        self.domain = domain
        self.signature = signature
        self.cusConfig = cusConf(usingSSL: cusConfig["usingSSL"] as? Bool, apiFilePath: cusConfig["apiFilePath"] as? String)
        if (isConnValid() == false){
            throw YOURLSErr.invalidConnection
        }
    }
    private func getScheme()-> String{
        if (cusConfig.isUsingSSL()){
            return "https"
        }else{
            return "http"
        }
    }
    
    public func isConnValid()-> Bool{
        let response = tools.sendHTTP(url: "\(self.getScheme())://\(domain)/\(cusConfig.getApiFilePath())", method: httpMethod.GET, urlParams: ["signature": self.signature, "action": "stats"], bodyParams: [:])
        if (response.statusCode == 200){
            return true
        }else{
            return false
        }
        
    }
}
