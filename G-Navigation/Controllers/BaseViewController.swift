//
//  BaseViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 30.01.2023.
//

//MARK: - Frameworks
import UIKit
import Lottie

//MARK: - UIViewController
class BaseViewController : UIViewController {
    //Configure Animation
    func configureAnimation(animationView: LottieAnimationView, _ name: String){
        animationView.animation = .named(name)
        animationView.backgroundColor = .systemBackground
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
    }
    
    //Alert Message
    func mapAlertMessage(alertTitle: String, alertMesssage: String) {
            let alertController = UIAlertController(title: alertTitle, message: alertMesssage, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
}
