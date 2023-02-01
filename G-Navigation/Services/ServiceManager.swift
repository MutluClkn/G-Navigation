//
//  ServiceManager.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 1.02.2023.
//

//MARK: - Frameworks
import Foundation
import CoreLocation


//MARK: - Errors
enum NetworkingError: Error{
    case custom(error: Error)
    case invalidData
    case failedToDecode(error: Error)
}

//MARK: - ServiceManager
final class ServiceManager {
    static let shared = ServiceManager()
    
    private init() {}
    
    //MARK: - Fetch Data
    func fetchData<T: Codable>(type: T.Type, origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, completion: @escaping (Result<T, Error>) -> Void){
        
        var url : URL?
        if type == NavigationData.self {
            url = Bundle.main.url(forResource: "navigation", withExtension: "json")
        }else{
            url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin.latitude),\(origin.longitude)&destination=\(destination.latitude),\(destination.longitude)&key=\(API_Keys.general_API_key)")
        }
        if let url {
            if type == DirectionData.self{
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, _, error in
                    if let error {
                        completion(.failure(NetworkingError.custom(error: error)))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(NetworkingError.invalidData))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                    }catch{
                        completion(.failure(NetworkingError.failedToDecode(error: error)))
                    }
                }
                    task.resume()
            }else{
                do{
                    let jsonData = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }catch{
                    completion(.failure(NetworkingError.failedToDecode(error: error)))
                }
            }
        }
    }
}
