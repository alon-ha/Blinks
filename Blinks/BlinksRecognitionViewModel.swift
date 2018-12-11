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

// As we discussed, in this task I wouldn't use RxSwift or such libraries.
// In general RxSwift will allow us to bind things between UI and logic in a very easy way
// Here I will do it with delegate

protocol BlinksRecognitionDelegation: class {
    func changeRectangle(forEye: Eye, color: UIColor)
    func startCameraTracking()
    func btnRecognizeVisibility(shouldShow: Bool)
    func showAlert(message: String)
}

protocol BlinksRecognitionViewModelingInputs {
    func btnRecognizePressed()
    func userBlinked(eye: Eye)
    func set(delegate: BlinksRecognitionDelegation)
}

protocol BlinksRecognitionViewModelingOutputs {
    var title: String { get }
}

protocol BlinksRecognitionViewModeling {
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
        let newColor = color(forBlinkNumber: blinksService.blinksNumber(eye: eye))
        delegate?.changeRectangle(forEye: eye, color: newColor)
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
