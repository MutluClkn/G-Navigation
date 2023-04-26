//
//  RegisterViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 29.03.2023.
//

//MARK: - Libraries
import UIKit
import FirebaseAuth
import FirebaseFirestore


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
                    self.alertMessage(alertTitle: "Error", alertMesssage: error.localizedDescription, completionHandler: nil)
                }else{
                    
                    //MARK: - Firestore
                    let uuid = UUID().uuidString
                    let docData : [String : Any] = [FirebaseConstants.uuid : uuid,
                                                    FirebaseConstants.email : email,
                                                    FirebaseConstants.fullName : fullName
                    ]
                    
                    Firestore.firestore().collection(FirebaseConstants.collectionName).document(uuid).setData(docData){ error in
                        if let error {
                         print(error)
                        } else {
                            self.alertMessage(alertTitle: "Congratulations", alertMesssage: "You have successfully registered."){
                                self.dismiss(animated: true)
                            }
                        }
                    }
                }
            }
        }else {
            self.alertMessage(alertTitle: "Error", alertMesssage: "Please fill all the necessary parts!", completionHandler: nil)
        }
    }
    
    //Back to Login Screen
    @IBAction func loginButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
