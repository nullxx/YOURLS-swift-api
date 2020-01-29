//
//  tools.swift
//  YOURLS
//
//  Created by Jon Lara Trigo on 29/01/2020.
//  Copyright © 2020 Jon Lara Trigo. All rights reserved.
//

import Foundation

public class tools{
    static public func sendHTTP(url: String, method: String, urlParams: Dictionary<String, Any>, bodyParams: Dictionary<String, Any>)-> YOURLSResponse {
        var finalResp: YOURLSResponse? = nil
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = dictToString(bodyParams)
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "\(url)?\(dictToString(urlParams))&format=json")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = method
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if (data != nil){
                finalResp = try! JSONDecoder().decode(YOURLSResponse.self, from: data!)
            }
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return finalResp!
    }
}

func dictToString(_ dict: Dictionary<String, Any>)-> String{
    var finalString = ""
    for p in dict{
        let toAppend = "\(p.key)=\(p.value)"
        if (finalString.count > 0){
            finalString.append("&\(toAppend)")
        }else{
            finalString.append(toAppend)
        }
    }
    return  finalString

}
