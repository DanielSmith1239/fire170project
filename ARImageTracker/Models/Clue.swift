//
//  Clue.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/29/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import FirebaseCore
import Firebase

class Clue: Equatable {
    var imageName: String?
    var imageLink: String?
    var height: Double?
    var width: Double?
    var clueText: String?
    var detailText: String?
    var questionNumber: Int?
    
    var firestoreModel: [String: Any] {
        return [
            Keys.imageName: imageName ?? "",
            Keys.imageLink: imageLink ?? "",
            Keys.height: height ?? 0.0,
            Keys.width: width ?? 0.0,
            Keys.clueText: clueText ?? 0.0,
            Keys.detailText: detailText ?? 0.0,
            Keys.questionNumber: questionNumber ?? 0
        ]
    }
    
    init(closure: (Clue) -> Void) {
        closure(self)
    }
    
    static func == (lhs: Clue, rhs: Clue) -> Bool {
        return (lhs.imageName == rhs.imageName)
    }
    
    static let testClue = Clue {
        $0.imageName = ""
    }
}

private struct Keys {
    static let imageName = "image_name"
    static let imageLink = "image_link"
    static let height = "height"
    static let width = "width"
    static let clueText = "clue_text"
    static let detailText = "detail_text"
    static let questionNumber = "question_number"
}

