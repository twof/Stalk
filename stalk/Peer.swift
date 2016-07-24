//
//  Peer.swift
//  stalk
//
//  Created by fnord on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

class User{
    var peerID: String!
    var name: String!
    var latitude: Double!
    var longitude: Double!
    var points: Int!
    var depth: Int!
    
    init(peerID: String, name: String, latitude: Double, longitude: Double, points: Int, depth: Int){
        self.peerID = peerID
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.points = points
        self.depth = depth
    }
    
    func toJSON() -> String {
        
        return JSON(["peerID":self.peerID, "name":self.name, "latitude":self.latitude, "longitude":self.longitude , "point":self.points, "hop":self.depth]).rawString()!
        
    }
}

class Peer: PPKPeer {
    var name: String!
    var userDescription: String!
    var location:CLLocationCoordinate2D
    private var adjacencyListJson: [JSON]!
    var adjacencyList: [User]!

    
    init(json:JSON) {
        self.name = json["identification"]["name"].stringValue
        self.userDescription = json["identification"]["description"].stringValue
        self.location = CLLocationCoordinate2D(latitude: json["location"]["longitude"].doubleValue , longitude: json["location"]["latitude"].doubleValue)
        self.adjacencyListJson = json["users"].arrayValue
        for user in adjacencyListJson{
            self.adjacencyList.append(User(peerID: user["peerID"].stringValue, name: user["name"].stringValue, latitude: user["latitude"].doubleValue, longitude: user["longitude"].doubleValue, points: user["points"].intValue, depth: user["depth"].intValue))
        }
    }
    
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
