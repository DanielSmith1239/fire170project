//
//  ScavangerHuntCreatorView.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 10/29/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import Eureka

class ScavangerHuntCreatorViewController: FormViewController {
    private var cur = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtons()
        navigationItem.title = "Create"
        
        form +++
            Section()
                <<< TextRow("title") {
                    $0.title = "Title"
                }
            +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete], header: "Cliues") {
                $0.addButtonProvider = { section in
                    ButtonRow() {
                        $0.title = "Add New Clue"
                    }
                }
                $0.multivaluedRowToInsertAt = { index in
                    ClueRow(tag: self.getCurIndexString())
                }
                $0 <<< ClueRow(tag: getCurIndexString())
        }
    }
    
    private func setupBarButtons() {
        let leftButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem = rightButton
    }
    
    @objc private func saveButtonPressed() {
        let values = form.values()
        let gameTitle = values["title"] as? String
        var clues = [Clue]()
        var temp = 1
        while values["\(temp)"] != nil {
            clues.append(values["\(temp)"] as! Clue)
            temp += 1
        }
        
        let game = Game {
            $0.title = gameTitle
            $0.clues = clues
        }
        
        game.saveToFirebase()
    }
    
    @objc private func cancelButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    private func getCurIndexString() -> String {
        cur += 1
        return "\(cur)"
    }
}
