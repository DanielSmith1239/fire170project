//
//  QuestionAnalytic.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/17/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation

class QuestionAnalytic {
    private var start: Date!
    private var end: Date!
    
    var question: TriviaQuestion
    
    init(question: TriviaQuestion) {
        self.question = question
    }
    
    func setStarted() {
        start = Date()
    }
    
    func setEnded() {
        end = Date()
    }
}
