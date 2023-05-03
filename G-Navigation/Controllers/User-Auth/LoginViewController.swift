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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButtonOutlet: UIButton!
    
    
    //MARK: - Objects
    
    var rememberMe = false
    
    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remember me button
        checkRememberMeButton()
        
        //Hide Keyboard
        closeKeyboard()
    }
    
    //-----------------------------
    //MARK: - Methods
    //-----------------------------
    
    func checkRememberMeButton(){
        let userDefaults = UserDefaults.standard
        if userDefaults.string(forKey: UserDefaultsKeys.rememberMe) == "1" {
            rememberMeButtonOutlet.setImage(UIImage(systemName: "checkmark"), for: .normal)
            rememberMeButtonOutlet.alpha = 1
            rememberMe = true
            self.emailTextField.text = userDefaults.string(forKey: UserDefaultsKeys.email)
            self.passwordTextField.text = userDefaults.string(forKey: UserDefaultsKeys.password)
        }else{
            rememberMeButtonOutlet.setImage(UIImage(named: "tickbox"), for: .normal)
            rememberMeButtonOutlet.alpha = 0.4
            rememberMe = false
        }
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
                let userDefaults = UserDefaults.standard
                if strongSelf.rememberMe == true {
                    userDefaults.set("1", forKey: UserDefaultsKeys.rememberMe)
                    userDefaults.set(email, forKey: UserDefaultsKeys.email)
                    userDefaults.set(password, forKey: UserDefaultsKeys.password)
                }else if strongSelf.rememberMe == false {
                    userDefaults.set("2", forKey: UserDefaultsKeys.rememberMe)
                }
                alertController.dismiss(animated: true)
                self?.performSegue(withIdentifier: SegueConstants.loginToStartVC, sender: nil)
            }
        }
    }
    
    //Remember Me Button Pressed - Active Button
    @IBAction func rememberMeButtonDidPress(_ sender: UIButton) {
        if rememberMe == false {
            rememberMe = true
            rememberMeButtonOutlet.setImage(UIImage(systemName: "checkmark"), for: .normal)
            rememberMeButtonOutlet.alpha = 1
        }else if rememberMe == true{
            rememberMe = false
            rememberMeButtonOutlet.setImage(UIImage(named: "tickbox"), for: .normal)
            rememberMeButtonOutlet.alpha = 0.4
        }
        
    }
    
    //Register Button Pressed to navigate register screen
    @IBAction func registerButtonDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.loginToRegister, sender: nil)
    }
}
