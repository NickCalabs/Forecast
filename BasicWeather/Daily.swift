//
//  Daily.swift
//  BasicWeather
//
//  Created by Nick on 2/11/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import Foundation

struct Daily {
    let maxTemp: Int?
    let minTemp: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    var day: String?
    let dateFormatter = NSDateFormatter()
    
    
    init(dailyWeatherDict: [String: AnyObject]){
        maxTemp = dailyWeatherDict["temperatureMax"] as? Int
        minTemp = dailyWeatherDict["temperatureMin"] as? Int
        if let humidityFloat = dailyWeatherDict["humidity"] as? Double{
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipProbabilityFloat = dailyWeatherDict["precipProbability"] as? Double{
            precipProbability = Int(precipProbabilityFloat * 100)
        } else {
            precipProbability = nil
        }
        summary = dailyWeatherDict["summary"] as? String
        
        if let time = dailyWeatherDict["time"] as? Double {
            day = dayStringFromTime(time)
        }
        
    }
    
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.stringFromDate(date)
    }
    
    func dayStringFromTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.stringFromDate(date)
    }
}