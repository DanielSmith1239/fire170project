//
//  UIButton_Extensions.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/10/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    static func getSuperCoolRoundedButton(action: PopupAction, ignoreAction: Bool = false) -> UIButton {
        let temp = UIButton(type: UIButton.ButtonType.roundedRect)
        
        // Titile
        temp.setTitle(action.text, for: .normal)
        temp.titleLabel?.font = UIFont.boldSystemFont(ofSize: temp.titleLabel!.font.pointSize)
        temp.setTitleColor(UIColor.gray, for: .normal)
        
        // Insets
        let horizontal: CGFloat = 10
        let vertical = horizontal - 2
        temp.contentEdgeInsets = UIEdgeInsets(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
        
        // Border
        temp.layer.borderWidth = 3
        temp.layer.borderColor = UIColor.gray.cgColor
        
        // Action
        if !ignoreAction {
            temp.actionHandle(controlEvents: .touchUpInside, forAction: action.action)
        }
        
        temp.sizeToFit()
        temp.layer.cornerRadius = temp.bounds.size.height * 0.5
        return temp
    }
    
    private func actionHandleBlock(action:(() -> Void)? = nil) {
        struct __ {
            static var action :(() -> Void)?
        }
        
        if action != nil {
            __.action = action
        } else {
            __.action?()
        }
    }
    
    @objc private func triggerActionHandleBlock() {
        self.actionHandleBlock()
    }
    
    func actionHandle(controlEvents control: UIControl.Event, forAction action: @escaping () -> Void) {
        self.actionHandleBlock(action: action)
        self.addTarget(self, action: #selector(UIButton.triggerActionHandleBlock), for: control)
    }
}
