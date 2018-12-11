//  
//  ContentUpdater.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import ARKit

protocol ContentUpdaterServicing: class, ARSCNViewDelegate {
   func set(delegate: BlinksRecognitionDelegation)
    func set(device: MTLDevice)
}

class ContentUpdaterService: NSObject, ContentUpdaterServicing {
    weak var delegate: BlinksRecognitionDelegation?
    var device: MTLDevice!
    
    fileprivate lazy var rightEyeNode: SCNNode = {
        let geometry = ARSCNFaceGeometry(device: device)!
        let material = geometry.firstMaterial!
        material.diffuse.contents = ColorPalette.green
        let node = SCNNode(geometry: geometry)
        return node
    }()
    
    fileprivate lazy var eyesNodes: EyesNode = {
        let node = EyesNode()
        return node
    }()
    
    func set(delegate: BlinksRecognitionDelegation) {
        self.delegate = delegate
    }
    
    func set(device: MTLDevice) {
        self.device = device
    }
}

extension ContentUpdaterService {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // This class adds AR content only for face anchors.
        guard let faceAnchor = anchor as? ARFaceAnchor else { return nil }
        
        
        return rightEyeNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        
//        rightEyeNode.simdTransform = faceAnchor.rightEyeTransform
//        let rightEyeAncor = faceAnchor.left
//
        let geometry = rightEyeNode.geometry as! ARSCNFaceGeometry
        geometry.update(from: faceAnchor.geometry)
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
