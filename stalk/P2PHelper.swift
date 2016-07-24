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
    
    override init(){
        super.init()
        PPKController.enableWithConfiguration(APP_KEY, observer:self)
        PPKController.enableProximityRanging()
    }
    
    static func setNetworkStatus(/*network status*/){
        let myDiscoveryInfo = "/*network status*/".dataUsingEncoding(NSUTF8StringEncoding)
        PPKController.pushNewP2PDiscoveryInfo(myDiscoveryInfo)
    }
    
    func PPKControllerInitialized() {
        // ready to start discovering nearbys
        let myDiscoveryInfo = "Hello from Swift!, Hey Justin!".dataUsingEncoding(NSUTF8StringEncoding)
        NSLog("%@", String(myDiscoveryInfo))
        PPKController.startP2PDiscoveryWithDiscoveryInfo(myDiscoveryInfo, stateRestoration: false)
    }
    
    func p2pPeerDiscovered(peer: PPKPeer!) {
        let discoveryInfoString = NSString(data: peer.discoveryInfo, encoding:NSUTF8StringEncoding)
        NSLog("%@ is here with discovery info: %@", peer.peerID, discoveryInfoString!)
        
        if let dataFromString = peer.discoveryInfo{
            let json = JSON(data: dataFromString)
            PeerHelper.addNewPeerToList(Peer(json: json))
        }
    }
    
    func p2pPeerLost(peer: PPKPeer!) {
        NSLog("%@ is no longer here", peer.peerID)
        
        if let dataFromString = peer.discoveryInfo{
            let json = JSON(data: dataFromString)
            PeerHelper.removePeerFromList(Peer(json: json))
        }
    }
    
    func discoveryInfoUpdatedForPeer(peer: PPKPeer!) {
        let discoveryInfo = NSString(data: peer.discoveryInfo, encoding: NSUTF8StringEncoding)
        NSLog("%@ has updated discovery info: %@", peer.peerID, discoveryInfo!)
        
        if let dataFromString = peer.discoveryInfo{
            let json = JSON(data: dataFromString)
            PeerHelper.updatePeerFromList(Peer(json: json))
        }
    }
    
    func proximityStrengthChangedForPeer(peer: PPKPeer!) {
        if (peer.proximityStrength.rawValue > PPKProximityStrength.Weak.rawValue) {
            NSLog("%@ is in range, do something with it", peer.peerID);
        }
        else {
            NSLog("%@ is not yet in range", peer.peerID);
        }
    }

    private static func constructAnnounceString() -> String{
        //Data layout
        let announceString = "{\"identification\": { \"peerID\": \(PPKController.myPeerID()), \"name\": \(PeerHelper.ownAccount.name), \"description\": \(PeerHelper.ownAccount.description) }, \"location\": { \"longitude\": \(PeerHelper.ownAccount.getLongitude()), \"latitude\": \(PeerHelper.ownAccount.getLatitude())}, \"users\": \(PeerHelper.usersToString(PeerHelper.ownAccount.adjacencyList))"
        
        return announceString
    }
}
