//
//  PopupView.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/9/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit

class PopupView: UIView
{
    static let delay: TimeInterval = 0
    static let animationDuration: TimeInterval = 0.5
    
    var endPosition: CGFloat = 0
    
    init(height: CGFloat) {
        let screenSize = UIScreen.main.bounds
        endPosition = screenSize.height - height
        super.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: height))
        config()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(toY y: CGFloat, completion: ((Bool) -> Void)?) {
        let animations = {
            var newFrame = self.frame
            newFrame.origin.y = y
            self.frame = newFrame
        }
        
        UIView.animate(withDuration: PopupView.animationDuration, delay: PopupView.delay, options: .curveEaseInOut, animations: animations, completion: completion)
    }
    
    func animateIn(completion: ((Bool) -> Void)?) {
        animate(toY: endPosition, completion: completion)
    }
    
    func animateOut(completion: ((Bool) -> Void)?) {
        animate(toY: UIScreen.main.bounds.height, completion: completion)
    }
    
    private func config()
    {
        backgroundColor = UIColor.white
    }
}
