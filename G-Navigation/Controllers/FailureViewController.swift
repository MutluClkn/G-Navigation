//
//  FailureViewController.swift
//  G-Navigation
//
//  Created by Mutlu Çalkan on 30.01.2023.
//

import UIKit

final class FailureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueConstants.failtureToStart, sender: nil)
    }
    
}
