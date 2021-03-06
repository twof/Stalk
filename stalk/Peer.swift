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

class User: Equatable{
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

func ==(left: User, right: User) -> Bool {
    return left.peerID == right.peerID && left.depth == right.depth
}

class Peer: PPKPeer {
    var name: String!
    var userDescription: String!
    var location:CLLocationCoordinate2D
    var adjacencyList: [User]!
    var points: Int!
    var depth: Int!

    
    init(json:JSON) {
        let adjacencyListJson = json["users"].arrayValue
        self.points = 0
        self.depth = json["depth"].intValue
        self.name = json["identification"]["name"].stringValue
        self.userDescription = json["identification"]["description"].stringValue
        self.adjacencyList = []
        self.location = CLLocationCoordinate2D(latitude: json["location"]["longitude"].doubleValue , longitude: json["location"]["latitude"].doubleValue)
        
        
        self.adjacencyList.append(User(peerID: PPKController.myPeerID(), name: PeerHelper.name, latitude: PeerHelper.location.latitude, longitude: PeerHelper.location.longitude, points: PeerHelper.points, depth: PeerHelper.depth))
        
        for user in adjacencyListJson{
            self.adjacencyList.append(User(peerID: user["peerID"].stringValue, name: user["name"].stringValue, latitude: user["latitude"].doubleValue, longitude: user["longitude"].doubleValue, points: user["points"].intValue, depth: user["depth"].intValue + 1))
            
            
        }
        
        super.init()
        print(PPKController.myPeerID())
//        PeerHelper.userList = self.adjacencyList
        for user in self.adjacencyList
        {
            PeerHelper.userList.append(user)
        }
        P2PHelper.constructAnnounceString()
            
        self.removeRedundencies()
    }
    
    init(name: String, userDescription: String, location: CLLocationCoordinate2D, depth: Int) {
        self.name = name
        self.userDescription = userDescription
        self.location = location
        self.depth = depth
        self.points = 0
        self.adjacencyList = []

    }
    
    func getLongitude() -> Double {
        return location.longitude
    }
    
    func getLatitude() -> Double {
        return location.latitude
    }
    
    func removeRedundencies() {
        var newAdjacencyList = [User]()
        for (index, user) in adjacencyList.enumerate() {
            
            if user.depth > 3 {
                adjacencyList.removeAtIndex(index)
            }else if newAdjacencyList.contains(user) {
                if newAdjacencyList[newAdjacencyList.indexOf(user)!].depth > user.depth {
                    newAdjacencyList.removeAtIndex(newAdjacencyList.indexOf(user)!)
                    newAdjacencyList.append(user)
                }
            }else{
                newAdjacencyList.append(user)
            }
        }
        adjacencyList = newAdjacencyList
    }
}