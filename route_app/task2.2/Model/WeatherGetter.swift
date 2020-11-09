//
//  WeatherGetter.swift
//  task2.2
//
//  Created by Elizaveta on 5/16/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import Foundation

protocol WeatherGetterDelegate {
    func didGetWeather(weather: Weather)
    func didNotGetWeather(error: Error)
}

class WeatherGetter {
    
    private let openWeatherMapBaseURL = "https://api.weather.yandex.ru/v1/forecast"
    private let openWeatherMapAPIKey = "415c532b-4b2c-402d-81da-eb81a6190b9e"
    private var delegate: WeatherGetterDelegate
    
    init(delegate: WeatherGetterDelegate) {
        self.delegate = delegate
    }
    
    func getWeatherByCoordinates(latitude: Double, longitude: Double) {
        var weatherRequestURL = URLRequest(url: URL(string: "\(openWeatherMapBaseURL)?lat=\(latitude)&lon=\(longitude)&extra=true")!)
        weatherRequestURL.addValue("\(openWeatherMapAPIKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        getWeather(weatherRequestURL: weatherRequestURL)
    }
    
    private func getWeather(weatherRequestURL: URLRequest) {
        
        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = 3
        
        let dataTask = session.dataTask(with: weatherRequestURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let networkError = error {
                self.delegate.didNotGetWeather(error: networkError)
            }
            else {
                do {
                    let weatherData = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    let weather = Weather(weatherData: weatherData)
                    self.delegate.didGetWeather(weather: weather)
                }
                catch let jsonError as NSError {
                    self.delegate.didNotGetWeather(error: jsonError)
                }
            }
        }
        dataTask.resume()
    }
    
}
