//
//  StartViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 30.01.2023.
//

//MARK: - Frameworks
import UIKit

//MARK: - StartViewController
final class StartViewController: UIViewController {

    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    @IBAction func startButtonDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.toMapVC, sender: nil)
    }
    
    @IBAction func googleLicenseButton(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: StoryboardConstants.main, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardConstants.licenseVC) as! LicenseViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}
