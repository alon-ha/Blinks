//  
//  DLog.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import Foundation

public func DLog(_ items: Any..., separator: String = "\n", terminator: String = "\n") {
    #if DEBUG
    print(items, separator: separator, terminator: terminator)
    #endif
}
