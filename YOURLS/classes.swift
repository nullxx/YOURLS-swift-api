//
//  classes.swift
//  YOURLS
//
//  Created by Jon Lara Trigo on 29/01/2020.
//  Copyright © 2020 Jon Lara Trigo. All rights reserved.
//

import Foundation

// MARK: - cusConf
class cusConf {
    private let usingSSL: Bool
    private let apiFilePath: String
    public init(usingSSL: Bool?, apiFilePath: String?){
        self.usingSSL = usingSSL ?? true
        self.apiFilePath = apiFilePath ?? "yourls-api.php"
    }
    public func isUsingSSL()-> Bool {
        return self.usingSSL

    }
    public func getApiFilePath()-> String {
        return self.apiFilePath
    }
}
// MARK: - YOURLSActions
public struct YOURLSActions {
    static let shorturl = "shorturl"
    static let expand = "expand"
    static let urlStats = "url-stats"
    static let stats = "stats"
    static let dbStats = "db-stats"
}
// MARK: - httpMethod
public struct httpMethod {
    static let GET = "GET"
    static let POST = "POST"
}
// MARK: - YOURLSResponse
public struct YOURLSResponse: Codable {
    public let url: URLClass?
    public let stats: Stats?
    public let status, message, title, shorturl, longurl, keyword: String?
    public let statusCode: Int?
    public let link: Link?
    public let links: Dictionary<String, Link?>?
    public let dbStats: Stats?
    public let errorCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case url
        case stats
        case status
        case message
        case title
        case shorturl
        case longurl
        case keyword
        case statusCode
        case link
        case links
        case dbStats = "db-stats"
        case errorCode
    }
}
// MARK: - URLClass
public struct URLClass: Codable {
    public let keyword, url, title, date: String?
    public let ip: String?
}
// MARK: - Stats
public struct Stats: Codable {
    public let totalLinks, totalClicks: String?

    enum CodingKeys: String, CodingKey {
        case totalLinks = "total_links"
        case totalClicks = "total_clicks"
    }
}
// MARK: - Link
// Making title optional to supprt old versions of YOURLS.
public struct Link: Codable {
    let shorturl, url: String
    let timestamp, ip, clicks: String
    var title:String?
}
// MARK: - Errors
enum YOURLSErr: String, Error {
    case invalidConnection = "Check the configurations"
}

