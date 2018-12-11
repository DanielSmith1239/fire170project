//
//  ScrollingPopupViewContainer.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/15/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit

class ScrollingPopupViewContainer: BasicPopupInfoViewDelegate {
    private var views: [BasicPopupView]    
    private var currentViewIndex = 0
    
    var didStartQuestions: Bool {
        return currentViewIndex != 0
    }
    
    var scrollView: UIScrollView!
    
    init(views: [BasicPopupView]) {
        self.views = views
        setupScrollView()
    }
    
    func scrollToNext() {
        currentViewIndex += 1
        scrollToView(currentViewIndex)
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0, y: views[0].endPosition), size: views[0].frame.size))
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        
        var x: CGFloat = 0
        
        for view in views {
            view.delegate = self
            view.frame = CGRect(x: x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(view)
            x += view.frame.width
        }
        
        scrollView.contentSize = CGSize(width: x, height: scrollView.frame.size.height)
    }
    
    func shouldGoToNext() {
        scrollToNext()
    }
    
    private func scrollToView(_ viewIndex: Int) {
        currentViewIndex = viewIndex
        var frame = scrollView.frame
        frame.origin.x = frame.width * CGFloat(viewIndex)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated: true)
    }
}
