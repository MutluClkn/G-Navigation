//
//  RegisterViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 29.03.2023.
//

import UIKit
import FirebaseAuth

final class RegisterViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboard()
    }
    
    @IBAction func registerButtonDidPress(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text, let fullName = fullNameTextField.text {
            Auth.auth().createUser(withEmail: email, password: password){_, error in
                if let error{
                    self.alertMessage(alertTitle: "Error", alertMesssage: error.localizedDescription)
                }else{
                    self.alertMessage(alertTitle: "Success", alertMesssage: "Registration successed! You can return to the login screen by pressing the 'Login' button below.")
                }
            }
        }else {
            self.alertMessage(alertTitle: "Error", alertMesssage: "Please fill all the necessary parts!")
        }
    }
    
    //Back to Login Screen
    @IBAction func loginButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
