//
//  IDCardView.swift
//  Recon
//
//  Created by David Hodge on 9/16/18.
//  Copyright © 2018 Genesis Apps. All rights reserved.
//

import Foundation
import UIKit
import GhostTypewriter

class IDCardVIew : UIView {
    @IBOutlet weak var nameLabel: TypewriterLabel!
    @IBOutlet weak var ageLabel: TypewriterLabel!
    @IBOutlet weak var genderLabel: TypewriterLabel!
    
    var nameIsAnimating: Bool = false
    var ageIsAnimating: Bool = false
    var genderIsAnimating: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func didLoad() {
        //Place your initialization code here
        self.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameLabel.typingTimeInterval = 0.05
        self.ageLabel.typingTimeInterval = 0.05
        self.genderLabel.typingTimeInterval = 0.05
    }
    
    func setHidden(_ isHidden: Bool) {
        if (isHidden == false) {
            // Show view
            // Check if the view is already being shown
            if (self.isHidden == false) {
                // View is already being shown
                return
            } else {
                
                setAlphaOnAttributedLabel(nameLabel, 0)
                setAlphaOnAttributedLabel(ageLabel, 0)
                setAlphaOnAttributedLabel(genderLabel, 0)

                // Card just came into view, start typing animation
                nameIsAnimating = true
                nameLabel.startTypewritingAnimation() {
                    self.nameIsAnimating = false
                    
                    self.ageIsAnimating = true
                    self.ageLabel.startTypewritingAnimation() {
                        self.ageIsAnimating = false
                    }
                    
                    self.genderIsAnimating = true
                    self.genderLabel.startTypewritingAnimation() {
                        self.genderIsAnimating = false
                    }
                }
            }
        }
        
        self.isHidden = isHidden
    }
    
    func setAlphaOnAttributedLabel(_ label: TypewriterLabel?, _ alpha: CGFloat) {
        guard let attributedText = label?.attributedText else {
            return
        }
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        
        attributedString.addAttribute(.foregroundColor, value: label?.textColor.withAlphaComponent(alpha), range: NSRange(location:0, length: attributedString.length))
        label?.attributedText = attributedString
    }
}
