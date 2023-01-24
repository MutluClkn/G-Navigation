//
//  DistanceManager.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 24.01.2023.
//

import Foundation
import CoreLocation

struct DistanceManager {
    func performRequest(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, completion: @escaping (Result<String, Error>) -> Void){
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=\(origin.latitude),\(origin.longitude)&destinations=\(destination.latitude),\(destination.longitude)&key=AIzaSyBro8k6WZrXKinjZHMbvqH8itM2rxA89hk"
        
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
                        let distanceData = try decoder.decode(DistanceData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(distanceData.rows[0].elements[0].distance.text))
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
