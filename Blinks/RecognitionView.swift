//
//  RecognitionView.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import UIKit
import ARKit

// I know that in order to present only 2d on the screen, I could have used ARSKView
// I chose to use ARSCNView to support also 3d if in the future we would like to do so

class RecognitionView: ARSCNView {
    private lazy var configuration: ARFaceTrackingConfiguration = {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        return configuration
    }()
    
    func start() {
        session.run(configuration)
    }
}
