//
//  DirectionData.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 24.01.2023.
//

import Foundation

// MARK: - WeatherData
struct DirectionData : Codable {
    let routes: [Route]
}

// MARK: - Route
struct Route : Codable {
    let overview_polyline: OverviewPolyline
}

// MARK: - OverviewPolyline
struct OverviewPolyline : Codable{
    let points: String
}
