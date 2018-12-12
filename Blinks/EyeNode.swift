//
//  EyeNode.swift
//  Blinks
//
//  Created by Alon Haiut on 12/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import ARKit

class EyeNode: SCNNode {
    fileprivate struct Metrics {
        static let recHeight: CGFloat = 0.01
        static let recWidth: CGFloat = 0.03
    }
    
    override init() {
        let geometry = SCNPlane(width: Metrics.recWidth,
                                height: Metrics.recHeight)
        super.init()
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func change(color: UIColor) {
        self.geometry?.firstMaterial?.diffuse.contents = color
    }
}
