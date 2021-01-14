//
//  HomeViewController.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 25/11/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    let apiManager = ApiManager()
    let date = Date()
    var locationManager: CLLocationManager!
    let userDefaults = UserDefaults.standard
    var timeseriesArray: Array<Float> = []
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var bringUbrellaLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var waterImg1: UIImageView!
    @IBOutlet weak var waterImg2: UIImageView!
    @IBOutlet weak var waterImg3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        startLocationManger()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped(gesture:)))
        
        homeImg.addGestureRecognizer(tapGesture)
        homeImg.isUserInteractionEnabled = true
        
        let day = date.get(.weekday)
        
        self.userDefaults.set(day, forKey: "dayStored")
        
        let dayStored = self.userDefaults.integer(forKey: "dayStored")
        
        handleSWipe()
        
        checkDay(day: dayStored)
    }
    
    func handleSWipe() {
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeleft.direction = .left
        self.view.addGestureRecognizer(swipeleft)
        
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swiperight.direction = .right
        self.view.addGestureRecognizer(swiperight)
        
    }
    
    var i = 0
    var weekday = Date().get(.weekday)
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left {
            if i > 5 {
                i = 6
            } else {
                i = i + 1
                
                let timeseries = self.userDefaults.array(forKey: "timeseries") as? [Float]
                
                if timeseries![i] == 0.0 {
                    self.homeImg.image = UIImage(systemName: "sun.min")
                    self.bringUbrellaLabel.text = "Ingen fare for regn idag :)"
                    self.homeImg.rotateInfinite()
                    UIView.animate(withDuration: 3, animations: {
                        self.view.backgroundColor = .yellow
                    })
                    self.waterImg1.image = UIImage(named: "")
                    self.waterImg2.image = UIImage(named: "")
                    self.waterImg3.image = UIImage(named: "")
                } else {
                    self.homeImg.image = UIImage(systemName: "cloud.rain")
                    self.bringUbrellaLabel.text = "Ta med paraply idag, det blir regn"
                    self.waterImg1.image = UIImage(named: "waterDrop")
                    self.waterImg2.image = UIImage(named: "waterDrop")
                    self.waterImg3.image = UIImage(named: "waterDrop")
                    self.view.backgroundColor = .systemBackground
                    self.homeImg.stopRotation()
                    self.waterImg1.center.y = 0
                    self.waterImg2.center.y = 0
                    self.waterImg3.center.y = 0
                    UIView.animate(withDuration: 3, delay: 0, options: .repeat, animations: {
                        self.waterImg1.center.y += 700
                    })
                    UIView.animate(withDuration: 5, delay: 0, options: .repeat, animations: {
                        self.waterImg2.center.y += 500
                    })
                    UIView.animate(withDuration: 4, delay: 0, options: .repeat, animations: {
                        self.waterImg3.center.y += 600
                    })
                }
                
                weekday = weekday + 1
                if weekday == 8 {
                    weekday = 1
                }
                checkDay(day: weekday)
            }
        }
        
        if gesture.direction == .right {
            if i < 1 {
                i = 0
            } else {
                i = i - 1
                
                let timeseries = self.userDefaults.array(forKey: "timeseries") as? [Float]
                
                if timeseries![i] == 0.0 {
                    self.homeImg.image = UIImage(systemName: "sun.min")
                    self.bringUbrellaLabel.text = "Ingen fare for regn idag :)"
                    UIView.animate(withDuration: 3, animations: {
                        self.view.backgroundColor = .yellow
                    })
                    self.waterImg1.image = UIImage(named: "")
                    self.waterImg2.image = UIImage(named: "")
                    self.waterImg3.image = UIImage(named: "")
                    self.homeImg.rotateInfinite()
                } else {
                    self.homeImg.image = UIImage(systemName: "cloud.rain")
                    self.bringUbrellaLabel.text = "Ta med paraply idag, det blir regn"
                    self.waterImg1.image = UIImage(named: "waterDrop")
                    self.waterImg2.image = UIImage(named: "waterDrop")
                    self.waterImg3.image = UIImage(named: "waterDrop")
                    self.view.backgroundColor = .systemBackground
                    self.homeImg.stopRotation()
                    self.waterImg1.center.y = 0
                    self.waterImg2.center.y = 0
                    self.waterImg3.center.y = 0
                    UIView.animate(withDuration: 3, delay: 0, options: .repeat, animations: {
                        self.waterImg1.center.y += 700
                    })
                    UIView.animate(withDuration: 5, delay: 0, options: .repeat, animations: {
                        self.waterImg2.center.y += 500
                    })
                    UIView.animate(withDuration: 4, delay: 0, options: .repeat, animations: {
                        self.waterImg3.center.y += 600
                    })
                }
                
                weekday = weekday - 1
                if weekday == 0 {
                    weekday = 7
                }
                checkDay(day: weekday)
            }
        }
    }
    
    func checkDay(day: Int) {
        switch day {
        case 1:
            print("Søndag")
            dayLabel.text = "Søndag"
        case 2:
            print("Mandag")
            dayLabel.text = "Mandag"
        case 3:
            print("Tirsdag")
            dayLabel.text = "Tirsdag"
        case 4:
            print("Onsdag")
            dayLabel.text = "Onsdag"
        case 5:
            print("Torsdag")
            dayLabel.text = "Torsdag"
        case 6:
            print("Fredag")
            dayLabel.text = "Fredag"
        case 7:
            print("Lørdag")
            dayLabel.text = "Lørdag"
        default:
            print("Did not find weekday")
        }
        print(date.get(.day))
    }
    
    var n = 0
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            n = n + 1
            switch n {
            case 1:
                self.homeImg.rotate()
            case 2:
                self.homeImg.zoom()
                n = 0
            default:
                print("No animations")
            }
        }
    }
    
    func startLocationManger() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

            apiManager.fetchApi(lat: "\(center.latitude)", lon: "\(center.longitude)") { (Weather) in
                let oneHour = Weather.properties?.timeseries?[0].data?.nextOneHours?.details?.precipitationAmount
                let sixHours = Weather.properties?.timeseries?[0].data?.nextSixHours?.details?.precipitationAmount
                let twelveHours = Weather.properties?.timeseries?[0].data?.nextTwelveHours?.details?.precipitationAmount
                
                let timeseries = Weather.properties?.timeseries
                
                for element in timeseries! {
                    let time = element.time?.split(separator: "T")
                    if time![1] == "08:00:00Z" || time![1] == "06:00:00Z" {
                        if time![1] == "08:00:00Z" && time![1] != "06:00:00Z" {
//                            print("I just need one")
                        } else {
                            self.timeseriesArray.append((element.data?.nextSixHours?.details?.precipitationAmount)! as Float)
                            
                            self.userDefaults.set(self.timeseriesArray, forKey: "timeseries")
                            
                        }
                        
                    }
                }
                
                let updatedAt = Weather.properties?.meta?.updatedAt
                
                self.userDefaults.set(oneHour, forKey: "oneHourStored")
                self.userDefaults.set(sixHours, forKey: "sixHoursStored")
                self.userDefaults.set(twelveHours, forKey: "twelveHoursStored")
                self.userDefaults.set(updatedAt, forKey: "updatedAtStored")
                
                
                if let updatedAtDate = self.userDefaults.string(forKey: "updatedAtStored") {
                    print("Updated at: \(updatedAtDate)")
                }
                
                let oneHourStored = self.userDefaults.float(forKey: "oneHourStored")
                let sixHoursStored = self.userDefaults.float(forKey: "sixHoursStored")
                let twelveHoursStored = self.userDefaults.float(forKey: "twelveHoursStored")
                
                self.timeseriesArray.insert(twelveHoursStored, at: 0)
                
                DispatchQueue.main.async {
                    if (oneHourStored == nil || oneHourStored == 0.0) && (sixHoursStored == nil || sixHoursStored == 0.0) && (twelveHoursStored == nil || twelveHoursStored == 0.0) {
                         self.homeImg.image = UIImage(systemName: "sun.min")
                        self.bringUbrellaLabel.text = "Ingen fare for regn idag :)"
                        self.homeImg.rotateInfinite()
                        UIView.animate(withDuration: 3, animations: {
                            self.view.backgroundColor = .yellow
                        })
                    } else {
                         self.homeImg.image = UIImage(systemName: "cloud.rain")
                        self.bringUbrellaLabel.text = "Ta med paraply idag, det blir regn"
                    }
                    
                    if let updatedAtStored = self.userDefaults.string(forKey: "updatedAtStored") {
                        let updatedAtFixed = updatedAtStored.components(separatedBy: "T")
                        self.updatedAtLabel.text = "\(updatedAtFixed[0]) \(updatedAtFixed[1])"
                    }
                }
            }
        }
    }
}

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension UIView {
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 3
        rotation.isCumulative = true
        rotation.autoreverses = true
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func zoom() {
        UIView.animate(withDuration: 3, animations: {
            self.transform = CGAffineTransform(scaleX: 9.0, y: 9.0)
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func stopRotation() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.duration = 0
        rotation.isCumulative = true
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func rotateInfinite() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 3
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func changeBackgroundColor() {
        let homeview = HomeViewController()
        UIView.animate(withDuration: 3, animations: {
            homeview.view.backgroundColor = .yellow
        })
    }
}
