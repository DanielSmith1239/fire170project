//
//  TriviaGame.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/3/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation

struct TriviaGame
{
    var questions: [TriviaQuestion]
    var views: [BasicPopupView]!
    var currentQuestion = 0
    
    init(questions: [TriviaQuestion]) {
        self.questions = questions
        setupViews()
    }
    
    func isCorrectImage(image: DetectionImage) -> Bool {
        if (currentQuestion >= questions.count) {
            return false
        }
        
        return (questions[currentQuestion].imageTarget.id == image.id)
    }
    
    private let getStartedView = BasicPopupView(title: "Get Started", details: "Tap the button below to begin the game.", usesContinueButton: true)
    private let completedView = BasicPopupView(title: "Great Job!", details: "You completed the game! Close and re-open the app to begin again.")

    private mutating func setupViews() {
        views = [BasicPopupView]()
        views.append(getStartedView)
        
        for question in questions {
            views.append(BasicPopupView(title: "Clue", details: question.clue))
            views.append(BasicPopupView(title: question.imageTarget.name, details: question.infoText, usesContinueButton: true))
        }
        
        views.append(completedView)
    }
}
