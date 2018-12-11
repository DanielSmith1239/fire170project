//
//  TriviaQuestion.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/3/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation

class TriviaQuestion
{    
    var clue: String
    var imageTarget: DetectionImage
    var infoText: String
    
    init(clue: String, imageTarget: DetectionImage, infoText: String) {
        self.clue = clue
        self.imageTarget = imageTarget
        self.infoText = infoText
    }
    
    static let questions = [
        TriviaQuestion(
            clue: "A lunch with friends with hopes that the party never ends.",
            imageTarget: DetectionImage(imageName: "Luncheon of the Boating Party-id-1637"),
            infoText: "The painting captures an idyllic atmosphere as Renoir's friends share food, wine, and conversation on a balcony overlooking the Seine at the Maison Fournaise restaurant in Chatou. Parisians flocked to the Maison Fournaise to rent rowing skiffs, eat a good meal, or stay the night. The painting also reflects the changing character of French society in the mid- to late 19th century."
        ),
        TriviaQuestion(
            clue: "'I enjoy long walks on the beach... with my nobel steed.\"",
            imageTarget: DetectionImage(imageName: "Beach Ponies-id-111"),
            infoText: "Reynolds Beal, the older brother of Gifford, was a long-time student of William Merritt Chase. From the beginning Beal’s playful, fun-filled subjects were popular. Over the course of his career, Reynolds Beal used a variety of styles, including impressionism. His most active artistic period was 1910-1930. He took his scenes from various places along the Eastern seaboard. Beach Ponies is an Atlantic City scene, painted in a style reminiscent of van Gogh."
        ),
    ]
}
