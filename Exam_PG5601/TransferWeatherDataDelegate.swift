//
//  TransferCoordsDelegate.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 05/11/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import Foundation

protocol TransferWeatherDataDelegate {
    func sendCoords(latitude: String, longitude: String)
    func sendWeatherType(type: String)
}
