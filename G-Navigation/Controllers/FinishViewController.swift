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
        configureAnimation(animationView: successAnimation, AnimationConstants.successName)
    }

    
    //-----------------------------
    //MARK: - Actions
    //-----------------------------
    
    @IBAction func restartButtonDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.toStartVC, sender: nil)
    }
    
    
}
