//
//  OpenPortalRequest.swift
//  RFPortals
//
//  Created by goliatone on 12/9/18.
//  Copyright © 2018 goliatone. All rights reserved.
//

import Foundation

struct OpenPortalRequest: Codable {
    var userId: String
    var portalAlias: String
    var timestamp: Int
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case portalAlias = "portal_alias"
        case timestamp
    }
}
