//
//  RectangleView.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import UIKit

// The reason this class exist and I won't use just a UIView, is because maybe in the future
// We would like to customise this view with a round corners for example and etc..

class RectangleView: UIView {
    func change(color: UIColor) {
        backgroundColor = color
    }
}
