//
//  Forecast.swift
//  BasicWeather
//
//  Created by Nick on 2/10/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import Foundation

struct Forecast{
    
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    init(APIKey: String){
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(lat: Double, long: Double, completion: (Weather? -> Void)){
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL){
            let networkOperation = Network(url: forecastURL)
            
            networkOperation.downloadJSONFromURL{
                (let JSONDictionary) in
                let forecast = Weather(weatherDictionary: JSONDictionary)
                completion(forecast)
                
            }
        } else {
            print("could not construct url")
        }
    }
    
}