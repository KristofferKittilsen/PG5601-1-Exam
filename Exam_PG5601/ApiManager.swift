//
//  ApiManager.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 27/10/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import Foundation

class ApiManager {
    
    func fetchApi(lat: String, lon: String, completion: @escaping (_ weather: Weather) -> ()) {
        
        
        let lat = lat
        let lon = lon
        
        
        let url = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(lat)&lon=\(lon)")!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            
            if let error = error {
                print("Failed to fetch data with error: ", error)
                return
            }
            
            guard let data = data else {return}
            
            
            let decoder = JSONDecoder()
            let jsonData : Weather = try! decoder.decode(Weather.self, from: data)
            
            completion(jsonData)
            
                
        })
        task.resume()
    }
}
