//
//  ViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 19.01.2023.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GoogleMapsLicense
        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
        
        //CoreLocation
        configureLocationManager()
        
    }
    
    private func addGoogleMaps(lat: CLLocationDegrees, long: CLLocationDegrees){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    private func configureLocationManager(){
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print("Start Updating Location")
    }

    
}

extension ViewController: CLLocationManagerDelegate{
    
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     
     guard let location = locations.first else {
         print("Error while getting first location!")
         return
     }
     
     let coordinate = location.coordinate
     print("Coordinates fetched successfully.")
     
     addGoogleMaps(lat: coordinate.latitude, long: coordinate.longitude)
 }
    
}

