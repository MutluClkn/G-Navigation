//
//  LoginViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 23.03.2023.
//


//MARK: - Libraries
import UIKit
import FirebaseAuth

//MARK: - LoginViewController
final class LoginViewController: BaseViewController {
    
    //-----------------------------
    //MARK: - Properties
    //-----------------------------
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //View layer
        loginView.layer.masksToBounds = true
        loginView.layer.cornerRadius = loginView.frame.size.height * 0.1
        
        //Hide Keyboard
        closeKeyboard()
    }
    
    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    //Login Button Pressed
    @IBAction func loginButtonDidPress(_ sender: UIButton) {

        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(style: .large)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error {
                alertController.dismiss(animated: true)
                strongSelf.alertMessage(alertTitle: "Error", alertMesssage: error.localizedDescription, completionHandler: nil)
            }
            else {
                alertController.dismiss(animated: true)
                self?.performSegue(withIdentifier: SegueConstants.loginToStartVC, sender: nil)
            }
        }
    }
    
    //Register Button Pressed to navigate register screen
    @IBAction func registerButtonDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.loginToRegister, sender: nil)
    }
}
