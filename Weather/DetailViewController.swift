//
//  DetailViewController.swift
//  Weather
//
//  Created by Szekely Janos on 2022. 07. 22..
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dailyTempDataLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    let weatherFetch = WeatherFetcher()

    private let identifier = "ForacestCell"
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?q="
    private let forecastUrl = "https://api.openweathermap.org/data/2.5/forecast?q="
    
    var city: String!
    var forecastResults: ForecastResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        
        title = city
        
        getCurrentWeather()
        
        getForecastForCity(city: city)
    }

    //TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = self.forecastResults {
            return result.list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ForecastCell
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        if let result = forecastResults?.list[indexPath.row] {
            cell.backgroundColor = .darkGray
            content.text = "H: \(result.main.temp_max)° L: \(result.main.temp_min)°"
            content.image = UIImage(named: result.weather[0].main)
            content.secondaryText = "\(result.dt_txt)"
        }
        cell.contentConfiguration = content
        return cell
    }
    
    private func getCurrentWeather() {
        weatherFetch.getWeatherForCurrentLocationFor(url: baseURL, city: city, action: { result in
            DispatchQueue.main.async {
                self.currentWeatherImg.image = UIImage(named: result.weather[0].main)
                let tempperature = result.main.temp
                self.view.backgroundColor = tempperature > 20 ? .red : .blue
                self.temperatureLabel.text = "Temp: \(tempperature) °C"
                self.dailyTempDataLabel.text = "H: \(result.main.temp_max)° L: \(result.main.temp_min)°"
                self.descriptionLabel.text = result.weather[0].description.capitalized
            }
        })
    }
    
    private func getForecastForCity(city: String) {
        weatherFetch.getWeatherForecastForCitiy(url: forecastUrl, city: city, forecastAction: { result in
            DispatchQueue.main.async {
                self.forecastResults = result
                self.table.reloadData()
            }
        })
    }
}
