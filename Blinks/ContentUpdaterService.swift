//  
//  ContentUpdater.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import ARKit

// I didn't want to put this service inside the view model, as it is connected to the UI
// The whole role of this service is to represent content using ARKit
// However it still need to communicate with the view model. That's why I hold a weak referance to the view model
// Basically we could also hold a strong referance to the view model without any retain cycles, however the view controller does so, so we can hold a weak referance here

protocol ContentUpdaterServicing: class, ARSCNViewDelegate, ARSessionDelegate {
    func set(delegate: BlinksRecognitionDelegation)
    func set(viewModel: BlinksRecognitionViewModeling)
    func changeRectangle(forEye: Eye, color: UIColor)
}

class ContentUpdaterService: NSObject, ContentUpdaterServicing {
    fileprivate struct Metrics {
        static let recHeight: CGFloat = 0.01
        static let recWidth: CGFloat = 0.03
        static let recDefaultColor: UIColor = ColorPalette.basicGrey
    }
    
    weak var delegate: BlinksRecognitionDelegation?
    weak var viewModel: BlinksRecognitionViewModeling?
    
    fileprivate lazy var rightEyeNode: SCNNode = {
        let geometry = SCNPlane(width: Metrics.recWidth,
                                height: Metrics.recHeight)
        let material = geometry.firstMaterial!
        material.diffuse.contents = Metrics.recDefaultColor
        let node = SCNNode(geometry: geometry)
        return node
    }()
    
    fileprivate lazy var leftEyeNode: SCNNode = {
        let geometry = SCNPlane(width: Metrics.recWidth,
                                height: Metrics.recHeight)
        let material = geometry.firstMaterial!
        material.diffuse.contents = Metrics.recDefaultColor
        let node = SCNNode(geometry: geometry)
        return node
    }()
    
    func set(delegate: BlinksRecognitionDelegation) {
        self.delegate = delegate
    }
    
    func set(viewModel: BlinksRecognitionViewModeling) {
        self.viewModel = viewModel
    }
    
    func changeRectangle(forEye eye: Eye, color: UIColor) {
        let node: SCNNode
        switch eye {
        case .rightEye:
            node = rightEyeNode
        case .leftEye:
            node = leftEyeNode
        }
        node.geometry?.firstMaterial?.diffuse.contents = color
    }
}

extension ContentUpdaterService {

    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let faceAnchor = anchor as? ARFaceAnchor {
                let isTracking = faceAnchor.isTracked
                if !isTracking {
                    // ARFaceAnchor is no longer tracking
                    changeRectangle(forEye: .rightEye, color: Metrics.recDefaultColor)
                    changeRectangle(forEye: .leftEye, color: Metrics.recDefaultColor)
                    viewModel?.inputs.clearBlinksService()
                }
            }
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        node.addChildNode(rightEyeNode)
        node.addChildNode(leftEyeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        
        rightEyeNode.simdTransform = faceAnchor.rightEyeTransform
        leftEyeNode.simdTransform = faceAnchor.leftEyeTransform
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard let err = error as? ARError else {
            delegate?.showAlert(message: NSLocalizedString("generalError", comment:""))
            return
        }
        
        // Support the error we want
        let message: String
        switch err.code {
        case .cameraUnauthorized:
            message = NSLocalizedString("allowCameraAlert", comment:"")
        default:
            message = NSLocalizedString("generalError", comment:"")
        }
        
        delegate?.showAlert(message: message)
    }
}
