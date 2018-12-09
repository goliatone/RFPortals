//
//  Configuration.swift
//  RFPortals
//
//  Created by goliatone on 12/8/18.
//  Copyright © 2018 goliatone. All rights reserved.
//

import Foundation

class Configuration {
    
    static var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "open-portals.ngrok.io"
        components.path = "/open"
        return components
    }
    
    static let userId: String = "B5AB66DB-A91C-43AD-8DFE-732520343F12"
    
    static let scanningActivity: String = "com.goliatone.RFPortals.scanPortals"
}
