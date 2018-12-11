//
//  delegetion.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import UIKit

// As we discussed, in this task I wouldn't use RxSwift or such libraries.
// In general RxSwift will allow us to bind things between UI and logic in a very easy way
// Here I will do it with delegate

protocol BlinksRecognitionDelegation: class {
    func changeRectangle(forEye: Eye, color: UIColor)
    func startCameraTracking()
    func btnRecognizeVisibility(shouldShow: Bool)
    func showAlert(message: String)
}
