//
//  Network.swift
//  BasicWeather
//
//  Created by Nick on 2/10/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import Foundation

class Network{
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url: NSURL){
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion){
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request){
            (let data, let response, let error) in
            
            //1. check http response for get request
            
            if let httpResponse = response as? NSHTTPURLResponse{
                switch(httpResponse.statusCode){
                case 200:
                    //2. create json object with data
                    
                    do{
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject]
                        completion(jsonDictionary)
                    } catch {
                        print("get request not sucesful: \(httpResponse.statusCode)")
                    }
                default:
                    print("get request not sucesful: \(httpResponse.statusCode)")
                }
            } else {
                print("not valid http")
            }
        }
        
        dataTask.resume()
    }

}