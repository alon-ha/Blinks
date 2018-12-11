//
//  Eyes.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation

enum Eye : Int {
    case leftEye = 0
    case rightEye = 1
    
    var index: Int {
        return self.rawValue
    }
}
