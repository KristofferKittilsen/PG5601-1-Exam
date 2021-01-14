//
//  MapViewController.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 03/11/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UITabBarControllerDelegate, TransferWeatherDataDelegate, UIGestureRecognizerDelegate {
    func sendCoords(latitude: String, longitude: String) {
        mapInfoView.lat.text = latitude
        mapInfoView.lon.text = longitude
    }
    
    func sendWeatherType(type: String) {
        
        DispatchQueue.init(label: "mapViewLabel").async {
            
            DispatchQueue.main.async {
                if type == "cloudy" || type == "partlycloudy_night" {
                    self.mapInfoView.weatherImage.image = UIImage(systemName: "cloud")
                } else if (type == "fair_day") {
                    self.mapInfoView.weatherImage.image = UIImage(systemName: "sun.min")
                } else {
                    self.mapInfoView.weatherImage.image = UIImage(systemName: "sun.min")
                }
            }
        }
    }
    
    @IBOutlet weak var mapInfoView: MapInfoView!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    var weatherDataDelegate: TransferWeatherDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateSwitch.setOn(false, animated: true)
        
        self.tabBarController?.delegate = self
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 0.5
        
        self.mapView.addGestureRecognizer(longPressGesture)
    
    }
    
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBAction func toggleMap(_ sender: Any) {
        if stateSwitch.isOn {
            print("On")
            startLocationManger()
            
        } else {
            print("Off")
        }
    }
    
    @objc func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended && stateSwitch.isOn == false {
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            let point = gesture.location(in: self.mapView)
            let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self.mapView.addAnnotation(annotation)
            
            mapInfoView.lon.text = "\(coordinate.longitude)"
            mapInfoView.lat.text = "\(coordinate.latitude)"

        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is MapViewController {
            
        } else {
            
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
            
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = "Your possition"
            self.mapView.addAnnotation(annotation)

            self.mapView.setRegion(region, animated: true)
    
            self.weatherDataDelegate = self

            self.weatherDataDelegate?.sendCoords(latitude: "\(center.latitude)", longitude: "\(center.longitude)")
            
            let tabbarController = tabBarController?.viewControllers![1] as! UINavigationController
            let foreCastController = tabbarController.topViewController as! ForeCastController
            
            foreCastController.lat = "\(center.latitude)"
            foreCastController.lon = "\(center.longitude)"
            
            let apiManager = ApiManager()
            
            apiManager.fetchApi(lat: "\(center.latitude)", lon: "\(center.longitude)") { (Weather) in
                let oneHourSymbolCode = Weather.properties?.timeseries?[0].data?.nextOneHours?.summary?.symbolCode!
                self.weatherDataDelegate?.sendWeatherType(type: oneHourSymbolCode!)
            }

        }
    }
}
