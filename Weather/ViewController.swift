//
//  ViewController.swift
//  Weather
//
//  Created by Szekely Janos on 2022. 07. 21..
//

import UIKit

class ViewController: UITableViewController {
    
    private var cities = ["Budapest", "Cupertino", "London", "Sydney", "Tokyo", "Toronto"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Choose a city"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cities[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.city = cities[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

