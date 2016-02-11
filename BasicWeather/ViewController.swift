//
//  ViewController.swift
//  BasicWeather
//
//  Created by Nick on 2/10/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var blur: UIVisualEffectView!
    
    @IBOutlet weak var locationControl: UISegmentedControl!
    @IBAction func locationChanged(sender: UISegmentedControl) {
        switch locationControl.selectedSegmentIndex{
        case 0:
            coordinate = (40.712784,-74.005941)
            bgImage.image = UIImage(named: "NYC")
            retreiveWeatherForecast()
        case 1:
            coordinate = (37.77493,-122.419416)
            bgImage.image = UIImage(named: "SF")
            retreiveWeatherForecast()
        case 2:
            coordinate = (51.507351,-0.127758)
            bgImage.image = UIImage(named: "London")
            retreiveWeatherForecast()
        default:
            break
        }
    }
    
    @IBOutlet weak var weekTableView: UITableView!
    
    var weeklyWeather: [Daily] = []
    
    private let APIKey = "203bf0976335ed98863b556ed9f61f79"
    var coordinate: (lat: Double, long: Double) = (40.712784,-74.005941)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retreiveWeatherForecast()
        bgImage.image = UIImage(named: "NYC")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retreiveWeatherForecast(){
        let forecastService = Forecast(APIKey: APIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long){
            (let forecast) in
            if let weatherForecast = forecast,
            let currentWeather = weatherForecast.currentWeather {
                dispatch_async(dispatch_get_main_queue()){
                    if let temperature = currentWeather.temp{
                        self.currentTempLabel?.text = "\(temperature)º"
                    }
                    if let humidity = currentWeather.humidity{
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    if let precipitation = currentWeather.precipProbability{
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    self.weeklyWeather = weatherForecast.weekly
                    
                    if let highTemp = self.weeklyWeather.first?.maxTemp,
                        let lowTemp = self.weeklyWeather.first?.minTemp{
                            self.currentTempLabel?.text = "↑\(highTemp)º↓\(lowTemp)º"
                    }
                    self.weekTableView.reloadData()
                }
            }
        }
    }

    @IBAction func refreshWeather(sender: UIButton) {
        retreiveWeatherForecast()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeather.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        let dailyWeather = weeklyWeather[indexPath.row]
        cell.textLabel?.text = dailyWeather.day
        
        return cell
    }

}

