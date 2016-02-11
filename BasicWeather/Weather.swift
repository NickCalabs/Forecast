//
//  Weather.swift
//  BasicWeather
//
//  Created by Nick on 2/11/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import Foundation

struct Weather {
    var currentWeather: CurrentWeather?
    var weekly: [Daily] = []
    
    init(weatherDictionary: [String: AnyObject]?){
        if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String: AnyObject]{
            currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }
        if let weeklyWeatherArray = weatherDictionary?["daily"]?["data"] as? [[String: AnyObject]]{
            for dailyWeather in weeklyWeatherArray{
                let daily = Daily(dailyWeatherDict: dailyWeather)
                weekly.append(daily)
            }
        }
    }
}