//
//  RegisterViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 29.03.2023.
//

import UIKit

final class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerButtonDidPress(_ sender: UIButton) {
    }
    
    
    @IBAction func loginButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
