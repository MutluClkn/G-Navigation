//
//  FailureViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 30.01.2023.
//

//MARK: - Frameworks
import UIKit
import Lottie

//MARK: - FailureViewController
final class FailureViewController: UIViewController {

    @IBOutlet weak var failureAnimation: LottieAnimationView!
    
    //-----------------------------
    //MARK: - Lifecycle
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimation(animationView: failureAnimation, AnimationConstants.failureName)
    }
    
    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.failtureToStart, sender: nil)
    }
    
}
