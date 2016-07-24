//
//  PeerHelper.swift
//  stalk
//
//  Created by fnord on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import Foundation
import SwiftyJSON

class PeerHelper{
    static var ownAccount: Peer!
    static var peerList: [Peer]!
    
    static func addNewPeerToList(newPeer: Peer){
        if !peerList.contains(newPeer) {
            peerList.append(newPeer)
        }else{
            print("Peer already in list")
        }
    }
    
    static func removePeerFromList(peer: Peer){
        if peerList.contains(peer) {
            peerList.removeAtIndex(peerList.indexOf(peer)!)
        }
    }
    
    static func updatePeerFromList(peer: Peer){
        if peerList.contains(peer){
            peerList.removeAtIndex(peerList.indexOf(peer)!)
            peerList.append(peer)
        }
    }
    
    static func usersToString(arr:[User]) -> String {
        
        return JSON(arr.map{$0.toJSON()}).rawString()!
        
    }
}

func ==(left: Peer, right: Peer) -> Bool{
    if left.peerID == right.peerID {
        return true
    }else{
        return false
    }
}
