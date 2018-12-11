//
//  TriviaQuestionOption.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/3/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation

struct TriviaQuestionOption
{
    var optionText: String
    var isCorrect: Bool
    
    init(optionText: String, isCorrect: Bool = false)
    {
        self.optionText = optionText
        self.isCorrect = isCorrect
    }
}
