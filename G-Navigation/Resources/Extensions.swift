//
//  Extensions.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 30.01.2023.
//

//MARK: - Frameworks
import UIKit
import Lottie

//MARK: - UIViewController
extension UIViewController {
    //Configure Animation
    func configureAnimation(animationView: LottieAnimationView, _ name: String){
        animationView.animation = .named(name)
        animationView.backgroundColor = .systemBackground
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
    }
}
