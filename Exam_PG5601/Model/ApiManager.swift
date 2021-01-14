//
//  ApiManager.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 26/10/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import Foundation

class ApiManager {
    let url = "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.911166&lon=10.744810"
    
    func performApiRequest() {
        let url = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.911166&lon=10.744810")!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) -> Void in

            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                print(json)
            }
        })
        task.resume()
    }
}
