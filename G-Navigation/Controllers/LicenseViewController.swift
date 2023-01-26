//
//  LicenseViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 26.01.2023.
//

//MARK: - Frameworks
import UIKit
import GoogleMaps

//MARK: - LicenseViewController
final class LicenseViewController: UIViewController {
    
    @IBOutlet weak var licenseTextView: UITextView!
    
    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        licenseTextView.text = GMSServices.openSourceLicenseInfo()
    }
}
