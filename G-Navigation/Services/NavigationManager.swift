//
//  NavigationManager.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 24.01.2023.
//

import Foundation

struct NavigationManager {
    func performRequest(completion: @escaping (Result<NavigationData, Error>) -> Void){
        if let url = Bundle.main.url(forResource: "navigation", withExtension: "json") {
            do{
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let data = try decoder.decode(NavigationData.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }catch{
                completion(.failure(error))
            }
        }
    }
}
