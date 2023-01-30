//
//  StartViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 30.01.2023.
//

import UIKit

final class StartViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func startButtonDidPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.toMapVC, sender: nil)
    }
    
    
}
