//
//  NavigationData.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 20.01.2023.
//

//MARK: - Frameworks
import Foundation

//MARK: - NavigationData
struct NavigationData : Codable {
    let alert_message : String
    let user : [Users]
    let location : [Locations]
}

//MARK: - Users
struct Users : Codable {
    let name : String
    let surname: String
}

//MARK: - Locations
struct Locations : Codable {
    let distance : Double
    let lat : Double
    let long : Double
}
