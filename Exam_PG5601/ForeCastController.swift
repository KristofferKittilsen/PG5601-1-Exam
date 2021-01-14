//
//  ViewController.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 26/10/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import UIKit

class weatherValue {
    var whatHour: String
    var whatType: String
    var rainAmount: Float
    var weatherType: String
    var precipitationAmount: String
    init(whatHour: String, whatType: String, rainAmount: Float, weatherType: String, precipitationAmount: String) {
        self.whatHour = whatHour
        self.whatType = whatType
        self.rainAmount = rainAmount
        self.weatherType = weatherType
        self.precipitationAmount = precipitationAmount
    }
}

class ForeCastController: UIViewController, UITableViewDataSource, UITabBarControllerDelegate {
    

    var weatherValues: [weatherValue] = []
    
    var lat: String = "59.911166"
    var lon: String = "10.744810"
    
    let apiManager = ApiManager()
    
    var weatherDataDelegate: TransferWeatherDataDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coordsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.weatherValues.removeAll()
        makeCells()
    }
    
    func makeCells() {
        apiManager.fetchApi(lat: lat, lon: lon) { (Weather) in
            
            let oneHourSymbolCode = Weather.properties?.timeseries?[0].data?.nextOneHours?.summary?.symbolCode!
            let sixHourSymbolCode = Weather.properties?.timeseries?[0].data?.nextSixHours?.summary?.symbolCode!
            let twelveHourSymbolCode = Weather.properties?.timeseries?[0].data?.nextTwelveHours?.summary?.symbolCode!
            
            let oneHourRainAmount = Weather.properties?.timeseries?[0].data?.nextOneHours?.details?.precipitationAmount
            let sixHourRainAmount = Weather.properties?.timeseries?[0].data?.nextSixHours?.details?.precipitationAmount
            let twelveHourRainAmount = Weather.properties?.timeseries?[0].data?.nextTwelveHours?.details?.precipitationAmount
            
            let precipitationAmount = Weather.properties?.meta?.units?.precipitationAmount
            let airTemp = Weather.properties?.meta?.units?.airTemperature
            
            print("FetchApi Running")
            
            DispatchQueue.init(label: "another thread").async {
                let firstCell = weatherValue(whatHour: "Nå", whatType: "Temperature", rainAmount: 0, weatherType: "10 \(airTemp!)", precipitationAmount: precipitationAmount!)
                self.weatherValues.append(firstCell)
                
                
                if oneHourRainAmount != nil {
                    let secondCell = weatherValue(whatHour: "Next 1 hours", whatType: "Vær", rainAmount: oneHourRainAmount!, weatherType: oneHourSymbolCode!, precipitationAmount: precipitationAmount!)
                    self.weatherValues.append(secondCell)
                } else {
                    let secondCell = weatherValue(whatHour: "Next 1 hours", whatType: "Vær", rainAmount: 0, weatherType: oneHourSymbolCode!, precipitationAmount: precipitationAmount!)
                    self.weatherValues.append(secondCell)
                }
                
                if sixHourSymbolCode != nil {
                    let thirdCell = weatherValue(whatHour: "Next 6 hours", whatType: "Vær", rainAmount: sixHourRainAmount!, weatherType: sixHourSymbolCode!, precipitationAmount: precipitationAmount!)
                    self.weatherValues.append(thirdCell)
                } else {
                    let thirdCell = weatherValue(whatHour: "Next 6 hours", whatType: "Vær", rainAmount: 0, weatherType: sixHourSymbolCode!, precipitationAmount: precipitationAmount!)
                    self.weatherValues.append(thirdCell)
                }
                
                if twelveHourRainAmount != nil {
                    let fourthCell = weatherValue(whatHour: "Next 12 hours", whatType: "Vær", rainAmount: twelveHourRainAmount!, weatherType: twelveHourSymbolCode!, precipitationAmount: precipitationAmount!)
                    self.weatherValues.append(fourthCell)
                } else {
                    let fourthCell = weatherValue(whatHour: "Next 12 hours", whatType: "Vær", rainAmount: 0, weatherType: twelveHourSymbolCode!, precipitationAmount: precipitationAmount!)
                    self.weatherValues.append(fourthCell)
                }
                
        
                self.weatherDataDelegate?.sendCoords(latitude: self.lat, longitude: self.lon)
                self.weatherDataDelegate?.sendWeatherType(type: oneHourSymbolCode!)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    if (self.lat == "59.911166" && self.lon == "10.744810") {
                        self.coordsLabel.text = "Høyskolen Kristiania"
                    } else {
                        self.coordsLabel.text = "\(self.lat), \(self.lon)"
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nextHourCell = tableView.dequeueReusableCell(withIdentifier: "nextHourCell", for: indexPath) as! NextHourCell
        nextHourCell.whatHour.text = weatherValues[indexPath.row].whatHour
        nextHourCell.rainAmountLabel.text = "\(weatherValues[indexPath.row].rainAmount) \(weatherValues[indexPath.row].precipitationAmount)"
        nextHourCell.weatherLabel.text = weatherValues[indexPath.row].weatherType
        nextHourCell.whatTypeLabel.text = weatherValues[indexPath.row].whatType

        return nextHourCell
    }
}
