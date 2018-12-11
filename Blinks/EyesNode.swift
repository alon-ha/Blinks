//
//  EyesNode.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class EyesNode: SCNReferenceNode {
    
    private lazy var leftEyeNode = childNode(withName: "eyeLeft", recursively: true)!
    private lazy var rightEyeNode = childNode(withName: "eyeRight", recursively: true)!
    
    init() {
        guard let url = Bundle.main.url(forResource: "robotHead", withExtension: "scn", subdirectory: "Models.scnassets")
            else {
                fatalError("missing expected bundle resource")
        }
        super.init(url: url)!
        self.load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    /// - Tag: BlendShapeAnimation
    fileprivate var blendShapes: [ARFaceAnchor.BlendShapeLocation: Any] = [:] {
        didSet {
            guard let leftEyeBlink = blendShapes[.eyeBlinkLeft] as? Float,
                let rightEyeBlink = blendShapes[.eyeBlinkRight] as? Float else {
                    return
            }
            
            leftEyeNode.scale.z = 1 - leftEyeBlink
            rightEyeNode.scale.z = 1 - rightEyeBlink
        }
    }
}

extension EyesNode: FaceContentProtocol {
    func update(withFaceAnchor faceAnchor: ARFaceAnchor) {
        blendShapes = faceAnchor.blendShapes
    }
}
