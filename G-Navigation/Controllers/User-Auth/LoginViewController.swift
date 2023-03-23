//
//  LoginViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 23.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.masksToBounds = true
        loginView.layer.cornerRadius = loginView.frame.size.height * 0.1
    }

    @IBAction func loginButtonDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.loginToStartVC, sender: nil)
    }
    
}
