//
//  Peer.swift
//  stalk
//
//  Created by fnord on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import Foundation
//import SwiftyJSON
import CoreLocation

struct Request {
    var receiver:String
    var body:String
//    
//    init(json:JSON) {
//        self.receiver = json["receiver"].stringValue
//        self.body = json["httpRequest"].stringValue
//    }
}
class Peer: PPKPeer {
    var name: String!
    var userDescription: String!
    //var connectionStatus: String!
    //var facebookID: String!
    var location:CLLocationCoordinate2D
   // var requests:[Request]!
    //var responses:[Request]!
    
//    init(json:JSON) {
//        self.name = json["identification"]["name"].stringValue
//        self.userDescription = json["identification"]["description"].stringValue
//        //self.connectionStatus = json["connectionStatus"]["networkStrength"].stringValue
//        //self.facebookID = json["identificatiom"]["facebookID"].stringValue
//        self.location = CLLocationCoordinate2D(latitude: json["location"]["longitude"].doubleValue , longitude: json["location"]["latitude"].doubleValue)
//        //self.requests = json["requests"].arrayValue.map(Request.init)
//        //self.responses = json["responses"].arrayValue.map(Request.init)
//    }
    
    init(name: String, userDescription: String, facebookID: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.userDescription = userDescription
        //self.facebookID = facebookID
        self.location = location
    }
    
    func getLongitude() -> Double {
        return location.longitude
    }
    
    func getLatitude() -> Double {
        return location.latitude
    }
    
    
}
