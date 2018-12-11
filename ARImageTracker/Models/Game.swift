//
//  Game.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 11/9/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import Firebase

class Game {
    private static let firebaseKey = "games"
    private static let countKey = "COUNT"
    var gameCode: Int?
    var title: String?
    var clues: [Clue]?
    
    var firestoreModel: [String: Any] {
        return [
            Keys.gameCode: gameCode ?? getGameKey(),
            Keys.title: title ?? "",
            Keys.clues: clues?.map { $0.firestoreModel } ?? []
        ]
    }
    
    init(closure: (Game) -> ()) {
        closure(self)
    }
    
    func saveToFirebase() {
        let collection = Firestore.firestore().collection(Game.firebaseKey)
        collection.addDocument(data: firestoreModel)
        collection.document(Game.countKey).setData(["count": getGameKey() + 1])
    }
    
    private func getGameKey() -> Int {
        let doc = Firestore.firestore().collection(Game.firebaseKey).document(Game.countKey)
        return (doc.dictionaryWithValues(forKeys: ["count"])["count"] as? Int ?? 0) + 1
//        return 2
    }
    
    private class Keys {
        static let gameCode = "game_code"
        static let title = "title"
        static let clues = "clues"
    }
}
