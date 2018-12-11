//
//  ViewController.swift
//  ARImageTracker
//
//  Created by Daniel Smith on 3/6/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

typealias PopupData = (title: String, details: String, actions: [PopupAction])

class ViewController: UIViewController, ARSCNViewDelegate
{
    @IBOutlet var arSceneView: ARSCNView!
    var lastImageScanned = ""
    var currentSlideIndex = 0
    var slides: [PopupData]!
    var game = TriviaGame(questions: TriviaQuestion.questions)
    var scrollView: ScrollingPopupViewContainer!
    
    var temp = 0
    
    private var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOut(duration: 0.5),
            .removeFromParentNode()
        ])
    }
    
    private let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".serialSceneKitQueue")
    
    override func viewWillAppear(_ animated: Bool) {
        changeBackButton()
        resetSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arSceneView.delegate = self
        scrollView = ScrollingPopupViewContainer(views: game.views)
        navigationItem.title = "Scavanger Hunt"
        view.addSubview(scrollView.scrollView)
        setupNextViewButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arSceneView.session.pause()
    }
    
    private func setupLoadButton() {
        let button = UIBarButtonItem(title: "Load", style: .plain, target: self, action: #selector(loadButtonPressed))
        navigationItem.leftBarButtonItem = button
    }
    
    @objc private func loadButtonPressed() {
        // TODO
    }
    
    private func setupNextViewButton() {
        let button = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(barButtonPressed))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func barButtonPressed() {
        navigationController?.pushViewController(ScavangerHuntCreatorViewController(), animated: true)
    }
    
    private func resetSession() {
        let config = ARWorldTrackingConfiguration()
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        // Config the image recognition
        config.detectionImages = referenceImages
        arSceneView.session.run(config, options: [.removeExistingAnchors])
    }
        
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)  {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        updateQueue.async {
            // Create a plane to visualize the initial position of the detected image.
            let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.25
            planeNode.eulerAngles.x = -.pi/2
            node.addChildNode(planeNode)
            
            if self.lastImageScanned != referenceImage.name! {
                planeNode.runAction(self.imageHighlightAction)
                self.resetSession()
                self.lastImageScanned = referenceImage.name!
                
                let image = DetectionImage(referenceImage)
                if self.game.isCorrectImage(image: image) {
                    self.goToNextQuestion()
                }
            }
        }
    }
    
    func goToNextQuestion() {
        game.currentQuestion += 1
        scrollView.scrollToNext()
    }
    
    private func changeBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}
