//
//  PaintingInfoView.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 3/8/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit

class PaintingInfoView: PopupView
{
    private var titleLabel: UILabel!

    init()
    {
        super.init(height: 100.0)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfo(withImage image: DetectionImage)
    {
        titleLabel.text = image.name
    }
    
    func config()
    {
        let topLeftPadding: CGFloat = 15
        titleLabel = UILabel(frame: CGRect(x: topLeftPadding, y: topLeftPadding, width: bounds.width - topLeftPadding, height: 34))
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        addSubview(titleLabel)
    }
}
