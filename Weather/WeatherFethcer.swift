//
//  WeahterFethcer.swift
//  Weather
//
//  Created by Szekely Janos on 2022. 07. 21..
//

import Foundation

class WeatherFetcher {

    private let keyString = "1669a47b66deefec1d6d0a15ff7ead42"
    
    var action: ((WeatherResult) -> Void)?
    var forecastAction: ((ForecastResults) -> Void)?

    func getWeatherForCurrentLocationFor(url: String, city: String, action: ((WeatherResult) -> Void)?) {

        self.action = action
        
        guard let probeURL = URL(string: "\(url)\(city)&appid=\(keyString)&units=metric") else { return }
        print(probeURL)

        let task = URLSession.shared.dataTask(with: probeURL) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with response.")
                return
            }
            
            guard let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data else {
                print("Error with content")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let weatherResult = try decoder.decode(WeatherResult.self, from: data)
                self.action?(weatherResult)
            } catch {
                print("Oops" + error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getWeatherForecastForCitiy(url: String, city: String, forecastAction: ((ForecastResults) -> Void)?) {
        self.forecastAction = forecastAction
        
        guard let probeURL = URL(string: "\(url)\(city)&appid=\(keyString)&units=metric") else { return }
        print(probeURL)

        let task = URLSession.shared.dataTask(with: probeURL) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with response.")
                return
            }
            
            guard let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data else {
                print("Error with content")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let weatherResult = try decoder.decode(ForecastResults.self, from: data)
                self.forecastAction?(weatherResult)
            } catch {
                print("Oops" + error.localizedDescription)
            }
        }
        task.resume()
    }
}
