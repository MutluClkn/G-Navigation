//
//  DistanceData.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 24.01.2023.
//

import Foundation

// MARK: - WeatherData
struct DistanceData : Decodable {
    let rows: [Row]
}

// MARK: - Row
struct Row : Decodable{
    let elements: [Element]
}

// MARK: - Element
struct Element : Decodable {
    let distance: Distance
}

// MARK: - Distance
struct Distance : Decodable{
    let text: String
}
