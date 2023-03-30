//
//  LoginViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 23.03.2023.
//

import UIKit
import FirebaseAuth

final class LoginViewController: BaseViewController {
    
    @IBOutlet weak var loginView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.masksToBounds = true
        loginView.layer.cornerRadius = loginView.frame.size.height * 0.1
        
        closeKeyboard()
    }
    
    @IBAction func loginButtonDidPress(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(style: .large)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        self.performSegue(withIdentifier: SegueConstants.loginToStartVC, sender: nil)
    }
    
}
