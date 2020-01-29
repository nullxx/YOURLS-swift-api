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
// MARK: - httpMethod
public struct httpMethod {
    static let GET = "GET"
    static let POST = "POST"
}
// MARK: - YOURLSResponse
public struct YOURLSResponse: Codable {
    let url: URLClass?
    let stats: Stats?
    let status, message, title, shorturl: String?
    let statusCode: Int?
    let errorCode: Int?
}
// MARK: - URLClass
struct URLClass: Codable {
    let keyword, url, title, date: String?
    let ip: String?
}
// MARK: - Stats
struct Stats: Codable {
    let totalLinks, totalClicks: String?

    enum CodingKeys: String, CodingKey {
        case totalLinks = "total_links"
        case totalClicks = "total_clicks"
    }
}

// MARK: - Errors
enum YOURLSErr: Error {
    case invalidConnection
}

