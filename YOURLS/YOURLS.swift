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
    private func getScheme() -> String{
        if (cusConfig.isUsingSSL()){
            return "https"
        }else{
            return "http"
        }
    }
    
    public func isConnValid() -> Bool{
        let response = tools.sendHTTP(url: "\(self.getScheme())://\(domain)/\(cusConfig.getApiFilePath())", method: httpMethod.GET, urlParams: ["signature": self.signature, "action": YOURLSActions.stats], bodyParams: [:])
        if (response.statusCode == 200){
            return true
        }else{
            return false
        }
    }
    public func short(url: String, with: String = "", title: String = "") -> YOURLSResponse {
        return tools.sendHTTP(url: "\(self.getScheme())://\(domain)/\(cusConfig.getApiFilePath())", method: httpMethod.GET, urlParams: ["signature": self.signature, "action": YOURLSActions.shorturl, "url": url,"title": title, "keyword": with], bodyParams: [:])
    }
    public func expand(from keyword: String) -> YOURLSResponse {
        return tools.sendHTTP(url: "\(self.getScheme())://\(domain)/\(cusConfig.getApiFilePath())", method: httpMethod.GET, urlParams: ["signature": self.signature, "action": YOURLSActions.expand, "keyword": keyword], bodyParams: [:])
    }
    
    public func getStats(from shortenedUrl: String) -> Link? {
        return tools.sendHTTP(url: "\(self.getScheme())://\(domain)/\(cusConfig.getApiFilePath())", method: httpMethod.GET, urlParams: ["signature": self.signature, "action": YOURLSActions.urlStats, "shorturl": shortenedUrl], bodyParams: [:]).link
    }
    public func filterStats(from filter: String, limit: Int = 10) -> YOURLSResponse {
        return tools.sendHTTP(url: "\(self.getScheme())://\(domain)/\(cusConfig.getApiFilePath())", method: httpMethod.GET, urlParams: ["signature": self.signature, "action": YOURLSActions.stats, "filter": filter, "limit": limit], bodyParams: [:])
    }
    public func dbStats() -> Stats? {
        return tools.sendHTTP(url: "\(self.getScheme())://\(domain)/\(cusConfig.getApiFilePath())", method: httpMethod.GET, urlParams: ["signature": self.signature, "action": YOURLSActions.dbStats], bodyParams: [:]).dbStats
    }
}
