//  
//  BlinksService.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation

protocol BlinksServicing {
    func clearBlinks()
    func userBlinked(eye: Eye)
    func blinksNumber(eye: Eye) -> Int
}

class BlinksService: BlinksServicing {
    private struct Metrics {
        static let maxBlinks: Int = 6
    }
    
    // I could also implementing init function and init the array there
    // Chosed to do it as literal
    private var blinksArray = [0, 0]
    
    func clearBlinks() {
        // Notice that we can't do in in 'forEach' otherwise that would be my choice
        for i in 0 ..< blinksArray.count {
            blinksArray[i] = 0
        }
    }
    
    func userBlinked(eye: Eye){
        guard blinksArray[eye.index] < Metrics.maxBlinks else { return }
        blinksArray[eye.index] += 1
    }
    
    func blinksNumber(eye: Eye) -> Int {
        return blinksArray[eye.index]
    }
}
