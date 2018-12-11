//
//  Image.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 3/7/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import ARKit

class DetectionImage
{
    var name: String = "Error"
    var id: String = "0"
    
    var phillipsUrl: URL?
    {
        return URL(string: "http://www.phillipscollection.org/collection/browse-the-collection?\(id)")
    }
    
    init(imageName: String) {
        let separatedName = imageName.components(separatedBy: "id")
        name = separatedName[0].replacingOccurrences(of: "-", with: "")
        id = separatedName[1]
    }
    
    convenience init(_ referenceImage: ARReferenceImage)
    {
        self.init(imageName: referenceImage.name!)
    }
}
