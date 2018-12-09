//
//  NSDate+timestamp.swift
//  RFPortals
//
//  Created by goliatone on 12/8/18.
//  Copyright © 2018 goliatone. All rights reserved.
//

import Foundation

extension NSDate {
    var timestamp: Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
}
