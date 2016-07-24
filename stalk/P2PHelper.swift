//
//  P2PHelper.swift
//  stalk
//
//  Created by fnord on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import Foundation
import SwiftyJSON

class P2PHelper: NSObject, PPKControllerDelegate {
    
    static var anounceStringHolder = ""{
        didSet{
            PPKController.pushNewP2PDiscoveryInfo(oldValue.dataUsingEncoding(NSUTF8StringEncoding))
        }
    }
    
    override init(){
        super.init()
    }
    
    static func setNetworkStatus(newStatus: String){
        let myDiscoveryInfo = newStatus.dataUsingEncoding(NSUTF8StringEncoding)
        PPKController.pushNewP2PDiscoveryInfo(myDiscoveryInfo)
    }

    static func constructAnnounceString() -> String{
        //Data layout
//        let announceString = "{\"identification\": { \"peerID\": \"\(PPKController.myPeerID())\", \"name\": \"\(PeerHelper.ownAccount.name)\", \"description\": \"\(PeerHelper.ownAccount.userDescription)\" }, \"location\": { \"longitude\": \(PeerHelper.ownAccount.getLongitude()), \"latitude\": \(PeerHelper.ownAccount.getLatitude())}, \"users\": \(PeerHelper.usersToString(PeerHelper.ownAccount.adjacencyList)) }"
//        anounceStringHolder = announceString
//        return announceString
        
        let announceString = "{\"identification\": { \"peerID\": \"\(PPKController.myPeerID())\", \"name\": \"\(PeerHelper.name)\", \"description\": \"\(PeerHelper.userDescription)\" }, \"location\": { \"longitude\": \(PeerHelper.location.longitude), \"latitude\": \(PeerHelper.location.latitude)}, \"users\": \(PeerHelper.usersToString(PeerHelper.userList)) }"
        anounceStringHolder = announceString
        return announceString
    }
}
