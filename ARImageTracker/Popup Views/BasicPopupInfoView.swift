//
//  BasicPopupInfoView.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/10/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit

typealias PopupAction = (text: String, action: () -> Void)

class BasicPopupView: PopupView {
    private let padding: CGFloat = 15
    private var screenSize: CGRect!

    private var title: String
    private var details: String
    private var hasHideButton: Bool
    private var usesContinueButton: Bool
    private var actions: [PopupAction]?
    
    private var titleLabel: UILabel!
    private var detailBox: UITextView!
    private var hideButton: UIButton!
    private var isMinimized = false
    
    var delegate: BasicPopupInfoViewDelegate!
        
    init(title: String, details: String, hasHideButton: Bool = true, usesContinueButton: Bool = false, actions: [PopupAction]? = nil) {
        screenSize = UIScreen.main.bounds
        self.title = title
        self.details = details
        self.hasHideButton = hasHideButton
        self.actions = actions
        self.usesContinueButton = usesContinueButton
        super.init(height: 400.0)

        config()
    }
    
    @objc private func toggleHidden() {
        if isMinimized {
            show()
        } else {
            hide()
        }
        
        isMinimized = !isMinimized
    }
    
    private func hide() {
        hideButton.setTitle("Show", for: .normal)
        hideButton.sizeToFit()
        let animateTarget = frame.height - (padding * 2) - titleLabel.frame.height
        animate(toY: animateTarget, completion: nil)
    }
    
    private func show() {
        hideButton.setTitle("Hide", for: .normal)
        hideButton.sizeToFit()
        animate(toY: 0, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        let stackHeight: CGFloat = 50
        
        // Hide Button
        if hasHideButton {
            let action = (text: "Hide", action: {
                self.toggleHidden()
            })
            
            hideButton = UIButton.getSuperCoolRoundedButton(action: action, ignoreAction: true)
            
            // FIXME
            hideButton.addTarget(self, action: #selector(toggleHidden), for: .touchUpInside)
            
            hideButton.frame = CGRect(
                x: (bounds.size.width - padding - hideButton.bounds.size.width),
                y: padding,
                width: hideButton.bounds.size.width,
                height: hideButton.bounds.size.height
            )
            addSubview(hideButton)
        }
        
        // Title Label
        titleLabel = UILabel(frame: CGRect(x: padding, y: padding, width: bounds.width - padding, height: 34))
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        
        // Detail Box
        //The "+ 10" here is so the text doesn't show when the view is minimized on an iPhone X
        let detailY = titleLabel.frame.origin.y + titleLabel.frame.height + 10
        let detailWidth = frame.width - (padding * 2)
        let detailHeight = frame.height - padding - detailY - (stackHeight - padding)
        detailBox = UITextView(frame: CGRect(x: padding, y: detailY, width: detailWidth, height: detailHeight))
        detailBox.isEditable = false
        detailBox.isSelectable = false
        detailBox.font = UIFont.systemFont(ofSize: 18)
        detailBox.text = details
        
        addSubview(titleLabel)
        addSubview(detailBox)
        
        // Actions
        var buttons = [UIButton]()
        if let unwrappedActions = actions {
            for action in unwrappedActions {
                var tempAction = action
                tempAction.text += " >"
                let temp = UIButton.getSuperCoolRoundedButton(action: tempAction)
                buttons.append(temp)
            }
        } else if usesContinueButton {
            let tempAction = (text: "Next >", action: {
                self.delegate.shouldGoToNext()
            })
            
            let button = UIButton.getSuperCoolRoundedButton(action: tempAction)
            buttons.append(button)
        }
        
        if !buttons.isEmpty {
            let stackView = UIStackView(arrangedSubviews: buttons)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.alignment = .leading
            stackView.frame = CGRect(x: padding, y: frame.height - padding - stackHeight, width: bounds.width - (padding * 2), height: stackHeight)
            stackView.semanticContentAttribute = .forceLeftToRight
            
            let stretchingView = UIView()
            stretchingView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
            stretchingView.translatesAutoresizingMaskIntoConstraints = false
            stackView.insertArrangedSubview(stretchingView, at: 0)
            stackView.spacing = 15
            
            addSubview(stackView)
        }
    }
}
