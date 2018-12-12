//
//  BlinksColorProvider.swift
//  Blinks
//
//  Created by Alon Haiut on 12/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation
import UIKit

protocol BlinksColorProviding {
    func color(forBlinkNumber: Int) -> UIColor
}

class BlinksColorProvider: BlinksColorProviding {
    private var colorsMap: [Int: UIColor] = [0: ColorPalette.basicGrey,
                                             1:  ColorPalette.red,
                                             2: ColorPalette.blue,
                                             3: ColorPalette.black,
                                             4:  ColorPalette.yellow,
                                             5: ColorPalette.pink,
                                             6: ColorPalette.green]
    
    func color(forBlinkNumber blinkNumber: Int) -> UIColor {
        guard let color = colorsMap[blinkNumber] else {
            return ColorPalette.basicGrey
        }
        
        return color
    }
}
