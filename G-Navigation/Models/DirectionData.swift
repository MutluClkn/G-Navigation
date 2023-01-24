//
//  DirectionData.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 24.01.2023.
//

import Foundation

// MARK: - WeatherData
struct DirectionData : Decodable {
    let routes: [Route]
}

// MARK: - Route
struct Route : Decodable {
    let overview_polyline: OverviewPolyline
}

// MARK: - OverviewPolyline
struct OverviewPolyline : Decodable{
    let points: String
}
