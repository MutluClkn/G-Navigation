//
//  ViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 19.01.2023.
//

//MARK: - Frameworks
import UIKit
import GoogleMaps
import CoreLocation


//MARK: - MapViewController
class MapViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var mapView: GMSMapView!
    
    
    
    //-----------------------------
    //MARK: - Objects
    //-----------------------------
    
    //CLLocation
    let manager = CLLocationManager()
    let startLocation = CLLocationCoordinate2D()
    let finishLocation = CLLocationCoordinate2D()
    
    
    
    
    
    //-----------------------------
    //MARK: - viewDidLoad
    //-----------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GoogleMaps
        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
        
        //CoreLocation
        configureLocationManager()
        
    }
    

    
    //-----------------------------
    //MARK: - Methods
    //-----------------------------
    
    //Add Google Maps
    private func addGoogleMaps(lat: CLLocationDegrees, long: CLLocationDegrees){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 13.0)
        mapView.camera = camera
        mapView.animate(to: camera)
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    //Configure Location Manager
    private func configureLocationManager(){
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print("Start Updating Location")
    }
    
    
    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    //Start Button
    @IBAction func startButtonDidPress(_ sender: UIButton) {
    }
    
    //Stop Button
    @IBAction func stopButtonDidPress(_ sender: UIButton) {
    }
    
}


//-----------------------------
//MARK: - CLLocationManagerDelegate
//-----------------------------

extension MapViewController: CLLocationManagerDelegate{
    //Did Update Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            print("Error while getting last location!")
            return
        }
        
        let coordinate = location.coordinate
        print("Coordinates fetched successfully.")
        
        addGoogleMaps(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("------FAIL------")
    }
    
}

