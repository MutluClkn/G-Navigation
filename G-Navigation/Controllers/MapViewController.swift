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
final class MapViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var mapView: GMSMapView!
    
    
    
    //-----------------------------
    //MARK: - Objects
    //-----------------------------
    
    //CLLocation
    let manager = CLLocationManager()
    let startLocation = CLLocationCoordinate2D()
    let finishLocation = CLLocationCoordinate2D()
    var currentCoordinates = CLLocationCoordinate2D()
    
    //Managers
    let navigationManager = NavigationManager()
    let directionManager = DirectionManager()
    
    //Fetched Datas
    var navigations : NavigationData?
    var points : String = ""
    
    //Location Count
    var destinations = [CLLocationCoordinate2D]()
    var succeedLocations : Int = 0
    
    
    
    //-----------------------------
    //MARK: - viewDidLoad
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CoreLocation
        configureLocationManager()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Managers
        fetchNavigationData()
        fetchDirectionData()
        
        self.destinations = []
    }
    
    
    
    //-----------------------------
    //MARK: - Methods
    //-----------------------------
    
    //Add Google Maps
    private func addGoogleMaps(startCoordinates: CLLocationCoordinate2D, finishCoordinates: CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withTarget: startCoordinates, zoom: 13.0)
        mapView.camera = camera
        mapView.animate(to: camera)
        
        
        // Creates a marker on the map.
        let startMarker = GMSMarker()
        startMarker.position = startCoordinates
        startMarker.title = "Start"
        startMarker.map = mapView
        
        let finishMarker = GMSMarker()
        finishMarker.position = finishCoordinates
        finishMarker.title = "Finish"
        finishMarker.map = mapView
        
    }
    
    //Configure Location Manager
    private func configureLocationManager(){
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print("Start Updating Location")
    }
    
    //Alert Message
    func alertMessage(alertTitle: String, alertMesssage: String) {
            let alertController = UIAlertController(title: alertTitle, message: alertMesssage, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
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
        
        for i in 0...2{
            guard let directionLat = self.navigations?.location[i].lat else { return }
            guard let directionLong = self.navigations?.location[i].long else { return }
            self.destinations.append(CLLocationCoordinate2D(latitude: directionLat, longitude: directionLong))
        }
        
    }
    
    //Fetch Direction Data
    private func fetchDirectionData(){
        guard let directionLat = self.navigations?.location[self.succeedLocations].lat else { return }
        guard let directionLong = self.navigations?.location[self.succeedLocations].long else { return }
        
        directionManager.performRequest(origin: CLLocationCoordinate2D(latitude: self.currentCoordinates.latitude, longitude: self.currentCoordinates.longitude), destination: CLLocationCoordinate2D(latitude: directionLat, longitude: directionLong)) { result in
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
    @IBAction func startBarButtonDidPress(_ sender: UIBarButtonItem) {
        manager.startUpdatingLocation()
    }
    
    //Stop Button
    @IBAction func stopBarButtonDidPress(_ sender: UIBarButtonItem) {
        manager.stopUpdatingLocation()
        self.mapView.clear()
        self.succeedLocations = 0
    }
    //Google License
    @IBAction func googleLicenseButtonDidPress(_ sender: UIButton) {
        performSegue(withIdentifier: SegueConstants.toLicenseVC, sender: nil)
    }
    
}


//-----------------------------
//MARK: - CLLocationManagerDelegate
//-----------------------------

extension MapViewController: CLLocationManagerDelegate{
    //Did Update Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.mapView.clear()
        fetchNavigationData()
        fetchDirectionData()
        
        guard let location = locations.last else {
            print("Error while getting last location!")
            return
        }
        
        self.currentCoordinates = location.coordinate
        print("Coordinates fetched successfully.")
        
        
        if self.succeedLocations <= 2 {
            if self.points != "" {
                
                let finishLat = self.destinations[self.succeedLocations].latitude
                let finishLong = self.destinations[self.succeedLocations].longitude
                
                guard let distanceJSON = self.navigations?.location[succeedLocations].distance else { return }
                
                guard let currentDistance = self.manager.location?.distance(from: CLLocation(latitude: finishLat, longitude: finishLong)) else { return }
                
                print("Target: \(distanceJSON)m,  Current Distance: \(currentDistance)")
                
                //If user arrived to target location
                if currentDistance < distanceJSON {
                    self.succeedLocations = self.succeedLocations + 1
                    
                    guard let message = self.navigations?.alert_message else { return }
                    self.alertMessage(alertTitle: "", alertMesssage: message)
                    
                    //If 3 locations completed
                    if self.succeedLocations == 3 {
                        self.succeedLocations = 0
                        let storyBoard : UIStoryboard = UIStoryboard(name: StoryboardConstants.main, bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardConstants.finishVC) as! FinishViewController
                        nextViewController.modalPresentationStyle = .fullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                    
                }
                
                let points = self.points
                let path = GMSPath(fromEncodedPath: points)
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = .systemBlue
                polyline.strokeWidth = 5
                polyline.map = self.mapView
                
                addGoogleMaps(startCoordinates: CLLocationCoordinate2D(latitude: self.currentCoordinates.latitude, longitude: self.currentCoordinates.longitude), finishCoordinates: CLLocationCoordinate2D(latitude: finishLat, longitude: finishLong))
                
                print("Current Stage: \(succeedLocations)")
                
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("------FAIL------")
    }
    
}


