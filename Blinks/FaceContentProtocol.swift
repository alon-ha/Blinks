//
//  FaceContentProtocol.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import ARKit

protocol FaceContentProtocol {
    func update(withFaceAnchor faceAnchor: ARFaceAnchor)
}
