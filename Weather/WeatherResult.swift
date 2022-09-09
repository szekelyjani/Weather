//
//  WeatherResult.swift
//  Weather
//
//  Created by Szekely Janos on 2022. 07. 21..
//

import Foundation

struct WeatherResult: Codable {
    var weather: [Weather]
    var name: String
    var main: Main
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
}

struct Main: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
}

struct ForecastResults: Codable {
    var cod: String
    var cnt: Int
    var list: [Forecast]
}

struct Forecast: Codable {
    var main: Main
    var weather: [Weather]
    var dt_txt: String
}
