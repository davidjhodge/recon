//
//  ViewController.swift
//  Recon
//
//  Created by David Hodge on 9/16/18.
//  Copyright © 2018 Genesis Apps. All rights reserved.
//

import UIKit
import GhostTypewriter

class ViewController: UIViewController {

    @IBOutlet weak var reconLabel: TypewriterLabel!
    @IBOutlet weak var instructionsLabel: TypewriterLabel!
    @IBOutlet weak var beginLabel: TypewriterLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        reconLabel.typingTimeInterval = 0.05
        instructionsLabel.typingTimeInterval = 0.05
        beginLabel.typingTimeInterval = 0.05

        beginLabel.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(begin))
        beginLabel.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @objc func begin() {
        self.performSegue(withIdentifier: "ShowCameraSegue", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Pause for 1 second, then begin typing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Type recon label
            self.reconLabel.startTypewritingAnimation() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.instructionsLabel.startTypewritingAnimation() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.beginLabel.startTypewritingAnimation()
                        }
                    }
                }
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

