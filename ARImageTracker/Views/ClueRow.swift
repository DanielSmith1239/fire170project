//
//  ClueRow.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/29/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import Eureka

class ClueCell: Cell<Clue>, CellType, UITextFieldDelegate, UITextViewDelegate {
    typealias Value = Clue
    
    @IBOutlet weak var imageNameField: UITextField!
    @IBOutlet weak var imageLinkField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var widthField: UITextField!
    @IBOutlet weak var clueTextView: UITextView!
    @IBOutlet weak var detailTextView: UITextView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        update()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        update()
    }
    
    override func setup() {
        super.setup()
        imageNameField.delegate = self
        imageLinkField.delegate = self
        heightField.delegate = self
        widthField.delegate = self
        clueTextView.delegate = self
        detailTextView.delegate = self
    }
    
    override func update() {
        super.update()
        row.value = Clue {
            $0.imageName = imageNameField?.text ?? ""
            $0.imageLink = imageLinkField?.text ?? ""
            $0.height = Double(heightField?.text ?? "") ?? 0
            $0.width = Double(widthField?.text ?? "") ?? 0
            $0.clueText = clueTextView.text
            $0.detailText = detailTextView.text
        }
    }
}

final class ClueRow: Row<ClueCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<ClueCell>(nibName: "ClueCell")
    }
    
    
}
