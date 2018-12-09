//
//  NFCNDEFPayload.swift
//  RFPortals
//
//  Created by Emiliano Burgos on 12/8/18.
//  Copyright © 2018 Emiliano Burgos. All rights reserved.
//

import Foundation
import CoreNFC

extension NFCNDEFPayload {
    var stringValue: String  {
        if let payload = String.init(data: self.payload.advanced(by: 3), encoding: .utf8) {
            return payload
        }
        return ""
    }
}
