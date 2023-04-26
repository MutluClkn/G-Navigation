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
    //Configure Animation For Once
    func configureAnimation(animationView: LottieAnimationView, _ name: String){
        animationView.animation = .named(name)
        animationView.backgroundColor = .systemBackground
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
    }
    
    //Configure Looped Animation
    func loopAnimation(animationView: LottieAnimationView, _ name: String){
        animationView.animation = .named(name)
        animationView.backgroundColor = .systemBackground
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    //Alert Message
    func alertMessage(alertTitle: String?, alertMesssage: String?, completionHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: alertTitle, message: alertMesssage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completionHandler?()
        }
        
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }

    
    //Hide Keyboard
    func closeKeyboard(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardPressed))
        view.addGestureRecognizer(gestureRecognizer)
    }
    @objc func closeKeyboardPressed(){
        view.endEditing(true)
    }
}
