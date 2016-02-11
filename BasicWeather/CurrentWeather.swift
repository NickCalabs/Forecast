//
//  CurrentWeather.swift
//  BasicWeather
//
//  Created by Nick on 2/10/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import Foundation

struct CurrentWeather{
    let temp: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String? //might be description
    
    init(weatherDictionary: [String: AnyObject]){
        temp = weatherDictionary["temperature"] as? Int
        if let humidityFloat = weatherDictionary["humidity"] as? Double{
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipFloat = weatherDictionary["precipProbability"] as? Double{
            precipProbability = Int(precipFloat * 100)
        } else {
            precipProbability = nil
        }
        summary = weatherDictionary["summary"] as? String
    }
}