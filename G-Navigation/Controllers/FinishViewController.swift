//
//  FinishViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 25.01.2023.
//

import UIKit
import Lottie

class FinishViewController: UIViewController {

    @IBOutlet weak var successAnimation: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        successAnimationConfiraguration(AnimationConstants.successName)
    }

    private func successAnimationConfiraguration(_ name: String){
        successAnimation.animation = .named(name)
        successAnimation.backgroundColor = .systemBackground
        successAnimation.contentMode = .scaleAspectFit
        successAnimation.loopMode = .playOnce
        successAnimation.play()
    }
    
    @IBAction func restartButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}
