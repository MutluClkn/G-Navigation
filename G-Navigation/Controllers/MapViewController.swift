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
final class MapViewController: BaseViewController {
    
    //MARK: - Properties
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var lapseLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var frameView: UIView!
    
    
    //-----------------------------
    //MARK: - Objects
    //-----------------------------
    
    //CLLocation
    let manager = CLLocationManager()
    let startLocation = CLLocationCoordinate2D()
    let finishLocation = CLLocationCoordinate2D()
    var currentCoordinates = CLLocationCoordinate2D()
    
    //Fetched Datas
    var navigations : NavigationData?
    var points : String = ""
    
    //Location Count
    var destinations = [CLLocationCoordinate2D]()
    var succeedLocations : Int = 0
    
    //Timer
    var timer: Timer?
    var startTime: Date?
    var elapsedTime: TimeInterval = 0
    var lapTimes: [String] = []

    
    
    
    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CoreLocation
        configureLocationManager()
        
        //Timer
        startTimer()
        
        //Mapview Layer
        self.mapView.layer.masksToBounds = true
        self.mapView.layer.cornerRadius = 30
        
        //FrameView Layer
        self.frameView.layer.masksToBounds = true
        self.frameView.layer.cornerRadius = 35
        
        //TableView
        self.infoTableView.dataSource = self
        self.infoTableView.delegate = self
        
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
        startMarker.icon = UIImage(named: "user")
        startMarker.position = startCoordinates
        startMarker.title = "Start"
        startMarker.map = mapView
        
        let finishMarker = GMSMarker()
        if self.succeedLocations == 2 {
            finishMarker.icon = UIImage(named: "finish")
        }else {
            finishMarker.icon = UIImage(named: "target")
         }
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
    
    //Fetch Navigation Data
    private func fetchNavigationData(){
        
        ServiceManager.shared.fetchData(type: NavigationData.self, origin: CLLocationCoordinate2D(latitude: 0, longitude: 0), destination: CLLocationCoordinate2D(latitude: 0, longitude: 0)) { result in
            switch result {
            case .success(let data):
                self.navigations = data
            case .failure(let error):
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
        
        ServiceManager.shared.fetchData(type: DirectionData.self, origin: CLLocationCoordinate2D(latitude: self.currentCoordinates.latitude, longitude: self.currentCoordinates.longitude), destination: CLLocationCoordinate2D(latitude: directionLat, longitude: directionLong)) { result in
            switch result{
            case .success(let direction):
                self.points = direction.routes[0].overview_polyline.points
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //Timer Methods
    private func startTimer() {
        startTime = Date()
        self.timerLabel.text = "00:00:00"
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.updateElapsedTime()
        }
    }


    private func stopTimer() {
        timer?.invalidate()
        self.lapTimes.append(self.timerLabel.text ?? "00:00:00")
        self.infoTableView.reloadData()
        timer = nil
    }

    private func resetTimer() {
        stopTimer()
        elapsedTime = 0
    }
        
    private func updateElapsedTime() {
        guard let startTime = startTime else {
            return
        }
        elapsedTime = -startTime.timeIntervalSinceNow
        let minutes = Int(elapsedTime / 60)
        let seconds = Int(elapsedTime) % 60
        let milliseconds = Int((elapsedTime * 100).truncatingRemainder(dividingBy: 100))
        self.timerLabel.text = String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }


    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    //Give Up Button - Failure VC
    @IBAction func giveUpBarButtonDidPress(_ sender: UIBarButtonItem) {
        manager.stopUpdatingLocation()
        self.mapView.clear()
        self.succeedLocations = 0
        //Push VC
        let storyBoard : UIStoryboard = UIStoryboard(name: StoryboardConstants.main, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardConstants.failureVC) as! FailureViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
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
        //print("Coordinates fetched successfully.")
        
        
        if self.succeedLocations <= 2 {
            if self.points != "" {
                
                let finishLat = self.destinations[self.succeedLocations].latitude
                let finishLong = self.destinations[self.succeedLocations].longitude
                
                guard let distanceJSON = self.navigations?.location[succeedLocations].distance else { return }
                
                guard let currentDistance = self.manager.location?.distance(from: CLLocation(latitude: finishLat, longitude: finishLong)) else { return }
                
                //print("Target: \(distanceJSON)m,  Current Distance: \(currentDistance)")
                
                //If user arrived to target location
                if currentDistance < distanceJSON {
                    self.succeedLocations = self.succeedLocations + 1
                    stopTimer()
                    startTimer()
                    
                    //If 3 locations completed
                    if self.succeedLocations == 3 {
                        self.succeedLocations = 0
                        stopTimer()
                        self.performSegue(withIdentifier: SegueConstants.mapToSucces, sender: nil)
                    }
                    //If it is <=2
                    else{
                        guard let message = self.navigations?.alert_message else { return }
                        self.mapAlertMessage(alertTitle: "", alertMesssage: message)
                    }
                }
                
                let points = self.points
                let path = GMSPath(fromEncodedPath: points)
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = .systemBlue
                polyline.strokeWidth = 5
                polyline.map = self.mapView
              
                addGoogleMaps(startCoordinates: CLLocationCoordinate2D(latitude: self.currentCoordinates.latitude, longitude: self.currentCoordinates.longitude), finishCoordinates: CLLocationCoordinate2D(latitude: finishLat, longitude: finishLong))
                
                self.lapseLabel.text = "Laps: \(succeedLocations)/3"
                //print("Current Stage: \(succeedLocations)")
                
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("------FAIL------")
    }
    
}

//MARK: - UITableViewDataSource
extension MapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.infoCell, for: indexPath) as? InfoTableViewCell else {
            return UITableViewCell()
        }

        cell.timerLabel.text = String(format: "%d. \(self.lapTimes[indexPath.row])", indexPath.row + 1)
        cell.completeImageView.image = UIImage(named: "complete")
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MapViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Completed Destinations"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

