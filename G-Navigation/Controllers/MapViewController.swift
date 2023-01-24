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
    
    //Managers
    let navigationManager = NavigationManager()
    let directionManager = DirectionManager()
    
    //Fetched Datas
    var navigations : NavigationData?
    var points : String = ""
    
    //Location Count
    var succeedLocations : Int = 0
    
    
    
    //-----------------------------
    //MARK: - viewDidLoad
    //-----------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GoogleMaps
        //print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
        
        //CoreLocation
        configureLocationManager()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Managers
        fetchNavigationData()
        fetchDirectionData()
    }
    

    
    //-----------------------------
    //MARK: - Methods
    //-----------------------------
    
    //Add Google Maps
    private func addGoogleMaps(startCoordinates: CLLocationCoordinate2D, finishCoordinates: CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withTarget: startCoordinates, zoom: 13.0)
        mapView.camera = camera
        mapView.animate(to: camera)
        
        
        // Creates a marker in the center of the map.
        let startMarker = GMSMarker()
        startMarker.position = CLLocationCoordinate2D(latitude: startCoordinates.latitude, longitude: startCoordinates.longitude)
        startMarker.title = "Start"
        startMarker.map = mapView
        
        let finishMarker = GMSMarker()
        finishMarker.position = CLLocationCoordinate2D(latitude: finishCoordinates.latitude, longitude: finishCoordinates.longitude)
        finishMarker.title = "Finish"
        finishMarker.map = mapView

    }
    
    //Configure Location Manager
    private func configureLocationManager(){
       // manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print("Start Updating Location")
    }
    
    //Fetch Navigation Data
    private func fetchNavigationData(){
        navigationManager.performRequest { results in
            switch results{
            case.success(let data):
                self.navigations = data
            case.failure(let error):
                print(error)
            }
        }
    }
    
    //Fetch Direction Data
    private func fetchDirectionData(){
        
        guard let originLat = self.navigations?.user[0].current_location.latitude else { return }
        guard let originLong = self.navigations?.user[0].current_location.longitude else { return }
        guard let directionLat = self.navigations?.location[succeedLocations].lat else { return }
        guard let directionLong = self.navigations?.location[succeedLocations].long else { return }
        
        directionManager.performRequest(origin: CLLocationCoordinate2D(latitude: originLat, longitude: originLong), destination: CLLocationCoordinate2D(latitude: directionLat, longitude: directionLong)) { result in
            switch result {
            case.success(let direction):
                self.points = direction
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    //Start Button
    @IBAction func startButtonDidPress(_ sender: UIButton) {
        fetchNavigationData()
        fetchDirectionData()
        if self.points != "" {
            let points = self.points
            let path = GMSPath(fromEncodedPath: points)
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = .systemBlue
            polyline.strokeWidth = 5
            polyline.map = self.mapView
            
            guard let startLat = self.navigations?.user[0].current_location.latitude else { return }
            guard let startLong = self.navigations?.user[0].current_location.longitude else { return }
            guard let finishLat = self.navigations?.location[succeedLocations].lat else { return }
            guard let finishLong = self.navigations?.location[succeedLocations].long else { return }
            
            addGoogleMaps(startCoordinates: CLLocationCoordinate2D(latitude: startLat, longitude: startLong), finishCoordinates: CLLocationCoordinate2D(latitude: finishLat, longitude: finishLong))
        }
    }
    
    //Stop Button
    @IBAction func stopButtonDidPress(_ sender: UIButton) {
    }
    
}

/*
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
        
        addGoogleMaps(startCoordinates: coordinate.latitude, finishCoordinates: coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("------FAIL------")
    }
    
}

*/
