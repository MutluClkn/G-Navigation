//
//  RegisterViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 29.03.2023.
//

//MARK: - Libraries
import UIKit
import FirebaseAuth

//MARK: - RegisterViewController
final class RegisterViewController: BaseViewController {

    //-----------------------------
    //MARK: - Properties
    //-----------------------------
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    
    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboard()
    }
    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    //Register Button Pressed
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
