//
//  NavigationData.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 20.01.2023.
//

//MARK: - Frameworks
import Foundation

//MARK: - NavigationData
struct NavigationData : Decodable {
    let alert_message : String
    let user : [Users]
    let location : [Locations]
}

//MARK: - Users
struct Users : Decodable {
    let name : String
    let surname: String
    let current_location : CurrentLocations
}

//MARK: - Locations
struct Locations : Decodable {
    let distance : Double
    let lat : Double
    let long : Double
}

//MARK: - CurrentLocations
struct CurrentLocations : Decodable {
    let latitude : Double
    let longitude : Double
}
