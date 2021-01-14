//
//  Weather.swift
//  Exam_PG5601
//
//  Created by Kristoffer Kittilsen on 26/10/2020.
//  Copyright © 2020 Kristoffer Kittilsen. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let type: String?
    let geometry: Geometry?
    let properties: Properties?
}

struct Geometry: Decodable {
    let type: String?
}

struct Properties: Decodable {
    let meta: Meta?
    let timeseries: [Timeseries]?
}

struct Meta: Decodable {
    let updatedAt: String?
    let units: Units?
    
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
        case units
    }
}

struct Units: Decodable {
    let airTemperature: String?
    let precipitationAmount: String?
    
    enum CodingKeys: String, CodingKey {
        case airTemperature = "air_temperature"
        case precipitationAmount = "precipitation_amount"
    }
}

struct Timeseries: Decodable {
    let time: String?
    let data: Data?
}

struct Data: Decodable {
    let instant: Instant?
    let nextOneHours: NextOneHours?
    let nextSixHours: NextSixHours?
    let nextTwelveHours: NextTwelveHours?
    
    enum CodingKeys: String, CodingKey {
        case nextOneHours = "next_1_hours"
        case nextSixHours = "next_6_hours"
        case nextTwelveHours = "next_12_hours"
        case instant
    }
}

struct Instant: Decodable {
    let details: Details?
}

struct Details: Decodable {
    let airTemperature: Float?
    
    enum CodingKeys: String, CodingKey {
        case airTemperature = "air_temperature"
    }
}

struct NextOneHours: Decodable {
    let summary: OneHourSummary?
    let details: OneHourDetails?
}

struct OneHourDetails: Decodable {
    let precipitationAmount: Float?
    
    enum CodingKeys: String, CodingKey {
        case precipitationAmount = "precipitation_amount"
    }
}

struct OneHourSummary: Decodable {
    let symbolCode: String?
    
    enum CodingKeys: String, CodingKey {
        case symbolCode = "symbol_code"
    }
}

struct NextSixHours: Decodable {
    let summary: SixHourSummary?
    let details: SixHourDetails?
}

struct SixHourDetails: Decodable {
    let precipitationAmount: Float?
    
    enum CodingKeys: String, CodingKey {
        case precipitationAmount = "precipitation_amount"
    }
}

struct SixHourSummary: Decodable {
    let symbolCode: String?
    
    enum CodingKeys: String, CodingKey {
        case symbolCode = "symbol_code"
    }
}

struct NextTwelveHours: Decodable {
    let summary: TwelveHourSummary?
    let details: TwelveHourDetails?
}

struct TwelveHourDetails: Decodable {
    let precipitationAmount: Float?
    
    enum CodingKeys: String, CodingKey {
        case precipitationAmount = "precipitation_amount"
    }
}

struct TwelveHourSummary: Decodable {
    let symbolCode: String?
    
    enum CodingKeys: String, CodingKey {
        case symbolCode = "symbol_code"
    }
}



