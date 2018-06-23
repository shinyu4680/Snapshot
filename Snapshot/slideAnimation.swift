//
//  slideAnimation.swift
//  Snapshot
//
//  Created by kevin on 2018/6/23.
//  Copyright © 2018 KevinChang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func slideInFromLeft (duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        let transition = CATransition()
        if let delegate: AnyObject = completionDelegate {
            transition.delegate = delegate as? CAAnimationDelegate
        }
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.fillMode = kCAFillModeRemoved
        
        self.layer.add(transition, forKey: "slideFromLeftTransition")
    }
    
    func slideInFromRight (duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        let transition = CATransition()
        if let delegate: AnyObject = completionDelegate {
            transition.delegate = delegate as? CAAnimationDelegate
        }
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.fillMode = kCAFillModeRemoved
        
        self.layer.add(transition, forKey: "slideFromLeftTransition")
    }
}
