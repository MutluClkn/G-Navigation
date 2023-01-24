//
//  DirectionManager.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 24.01.2023.
//

import Foundation
import CoreLocation

struct DirectionManager {
    func performRequest(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, completion: @escaping (Result<String, Error>) -> Void){
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin.latitude),\(origin.longitude)&destination=\(destination.latitude),\(destination.longitude)&key=\(API_Keys.general_API_key)"
        if let urlString = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { data, _, error in
                if let error {
                    print(error)
                    return
                }
                if let data {
                    do{
                        let decoder = JSONDecoder()
                        let direction = try decoder.decode(DirectionData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(direction.routes[0].overview_polyline.points))
                        }
                    }catch{
                        print("ERROR DIRECTION MANAGER")
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
            
    }
}
