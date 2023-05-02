//
//  StartViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 30.01.2023.
//

//MARK: - Frameworks
import UIKit
import FirebaseFirestore
import FirebaseAuth

//MARK: - StartViewController
final class StartViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserName()
    }
    
    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    @IBAction func startButtonDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.startToMap, sender: nil)
    }
    
    @IBAction func googleLicenseButton(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: StoryboardConstants.main, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardConstants.licenseVC) as! LicenseViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    
    //-----------------------------
    //MARK: - Methods
    //-----------------------------
    
    private func fetchUserName(){
        Firestore.firestore().collection(FirebaseConstants.collectionName).addSnapshotListener { querySnapshot, error in
            if let error {
                print(error)
            }
            if querySnapshot?.isEmpty != true && querySnapshot != nil {
                for doc in querySnapshot!.documents {
                    if let email = doc.get(FirebaseConstants.email) as? String, let name = doc.get(FirebaseConstants.fullName) as? String {
                        if email == Auth.auth().currentUser?.email {
                            self.infoLabel.text = "Welcome \(name). We created a challenge for you. Press on the Start button when you are ready."
                        }
                    }
                }
            }
        }
    }
    
}
