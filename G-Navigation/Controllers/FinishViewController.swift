//
//  FinishViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 25.01.2023.
//

//MARK: - Frameworks
import UIKit
import Lottie

//MARK: - FinishViewController
final class FinishViewController: UIViewController {

    @IBOutlet weak var successAnimation: LottieAnimationView!
    
    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        successAnimationConfiraguration(AnimationConstants.successName)
    }

    
    //-----------------------------
    //MARK: - Methods
    //-----------------------------
    
    private func successAnimationConfiraguration(_ name: String){
        successAnimation.animation = .named(name)
        successAnimation.backgroundColor = .systemBackground
        successAnimation.contentMode = .scaleAspectFit
        successAnimation.loopMode = .playOnce
        successAnimation.play()
    }
    
    @IBAction func restartButtonDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.toStartVC, sender: nil)
    }
    
    
}
