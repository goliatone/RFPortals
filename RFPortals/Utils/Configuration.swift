//
//  Configuration.swift
//  RFPortals
//
//  Created by goliatone on 12/8/18.
//  Copyright © 2018 goliatone. All rights reserved.
//

import Foundation

class Configuration {
    
    static let scanningActivity: String = "com.goliatone.RFPortals.scanPortals"
    static var serviceEndpointKey: String = "serviceEndpoint"
    static var userIdKey: String = "userId"
    static var beaconUUIDKey: String = "beaconUUID"
    
    static var serviceEndpoint: String {
        get {
            if (UserDefaults.standard.object(forKey: Configuration.serviceEndpointKey) != nil) {
                return UserDefaults.standard.string(forKey: Configuration.serviceEndpointKey)!
            }
            return ""
        }
        
        set(value) {
            UserDefaults.standard.set(value, forKey: Configuration.serviceEndpointKey)
        }
    }
    
    static var serviceURL: URL? {
        return URL(string: Configuration.serviceEndpoint)
    }
    
    static var userId: String {
        get {
            
            if (UserDefaults.standard.object(forKey: Configuration.userIdKey) != nil) {
                return UserDefaults.standard.string(forKey: Configuration.userIdKey)!
            }
            return ""
        }
        
        set(value) {
            UserDefaults.standard.set(value, forKey: Configuration.userIdKey)
        }
    }
    
    static var beaconUUID: String {
        get {
            if (UserDefaults.standard.object(forKey: Configuration.beaconUUIDKey) != nil) {
                return UserDefaults.standard.string(forKey: Configuration.beaconUUIDKey)!
            }
            return ""
        }
        
        set(value) {
            UserDefaults.standard.set(value, forKey: Configuration.beaconUUIDKey)
        }
    }
}
