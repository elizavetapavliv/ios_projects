//
//  Weather.swift
//  task2.2
//
//  Created by Elizaveta on 5/16/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import Foundation

struct Weather {
    
    public let city: String
    public let condition: String
    public let temp: Int
    public let feelTemp: Int
    public let humidity: Int
    public let pressure: Int
    
    init(weatherData: [String: AnyObject]) {
        let infoDict = (weatherData["info"] as! [String: AnyObject])["tzinfo"] as! [String: AnyObject]
        city = infoDict["name"] as! String
        
        let factDict = weatherData["fact"] as! [String: AnyObject]
        condition = factDict["condition"] as! String
        temp = factDict["temp"] as! Int
        feelTemp = factDict["feels_like"] as! Int
        humidity = factDict["humidity"] as! Int
        pressure = factDict["pressure_mm"] as! Int
    }
}
