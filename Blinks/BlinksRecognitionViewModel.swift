//  
//  BlinksRecognitionViewModel.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import UIKit
import ARKit

protocol BlinksRecognitionViewModelingInputs {
    func btnRecognizePressed()
    func userBlinked(eye: Eye)
    func set(delegate: BlinksRecognitionDelegation)
    func clearBlinksService()
}

protocol BlinksRecognitionViewModelingOutputs {
    var title: String { get }
    func rectColor(forEye eye: Eye) -> UIColor 
}

protocol BlinksRecognitionViewModeling: class {
    var inputs: BlinksRecognitionViewModelingInputs { get }
    var outputs: BlinksRecognitionViewModelingOutputs { get }
}

class BlinksRecognitionViewModel: BlinksRecognitionViewModeling, BlinksRecognitionViewModelingInputs, BlinksRecognitionViewModelingOutputs {
    var inputs: BlinksRecognitionViewModelingInputs { return self }
    var outputs: BlinksRecognitionViewModelingOutputs { return self }
    
    weak var delegate: BlinksRecognitionDelegation?
    let blinksService: BlinksServicing
    
    init(blinksService: BlinksServicing = BlinksService()) {
        self.blinksService = blinksService
    }
    
    lazy var title: String = {
        return NSLocalizedString("Blinks", comment:"")
    }()
    
    func btnRecognizePressed() {
        guard ARFaceTrackingConfiguration.isSupported else {
            let message = NSLocalizedString("deviceNotSupportFaceTracking", comment:"")
            delegate?.showAlert(message: message)
            return
        }
        
        delegate?.btnRecognizeVisibility(shouldShow: false)
        delegate?.startCameraTracking()
    }
    
    func userBlinked(eye: Eye) {
        blinksService.userBlinked(eye: eye)
    }
    
    func clearBlinksService() {
        blinksService.clearBlinks()
    }
    
    func rectColor(forEye eye: Eye) -> UIColor {
        return color(forBlinkNumber: blinksService.blinksNumber(eye: eye))
    }
    
    func set(delegate: BlinksRecognitionDelegation) {
        self.delegate = delegate
    }
}

fileprivate extension BlinksRecognitionViewModel {
    func color(forBlinkNumber num: Int) -> UIColor {
        switch num {
        case 1:
            return ColorPalette.red
        case 2:
            return ColorPalette.blue
        case 3:
            return ColorPalette.black
        case 4:
            return ColorPalette.yellow
        case 5:
            return ColorPalette.pink
        case 6:
            return ColorPalette.green
        default:
            return ColorPalette.basicGrey
        }
    }
}
