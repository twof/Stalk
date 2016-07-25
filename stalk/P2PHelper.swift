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
            PPKController.pushNewP2PDiscoveryInfo(anounceStringHolder.dataUsingEncoding(NSUTF8StringEncoding))
        }
    }
    
    override init(){
        super.init()
    }
    
    static func setNetworkStatus(newStatus: String){
        let myDiscoveryInfo = newStatus.dataUsingEncoding(NSUTF8StringEncoding)
        PPKController.pushNewP2PDiscoveryInfo(myDiscoveryInfo)
    }

    static func constructAnnounceString(){
        //Data layout
//        let announceString = "{\"identification\": { \"peerID\": \"\(PPKController.myPeerID())\", \"name\": \"\(PeerHelper.ownAccount.name)\", \"description\": \"\(PeerHelper.ownAccount.userDescription)\" }, \"location\": { \"longitude\": \(PeerHelper.ownAccount.getLongitude()), \"latitude\": \(PeerHelper.ownAccount.getLatitude())}, \"users\": \(PeerHelper.usersToString(PeerHelper.ownAccount.adjacencyList)) }"
//        anounceStringHolder = announceString
//        return announceString
        
        let announceString = "{\"identification\": { \"peerID\": \"\(PPKController.myPeerID())\", \"name\": \"\(PeerHelper.name)\", \"description\": \"\(PeerHelper.userDescription)\" }, \"location\": { \"longitude\": \(PeerHelper.location.longitude), \"latitude\": \(PeerHelper.location.latitude)}, \"users\": \(PeerHelper.usersToString(PeerHelper.userList)) }"
        let charCount = announceString.characters.count
        var endCharCount: Int = 0
        var startCharIndex: String.Index
        let numberOfSegments: Int = charCount/50

        
        while  endCharCount < charCount{
            if endCharCount+50 > charCount {
                endCharCount = charCount-1
            }else{
                endCharCount += 50
            }
            var announceStringSegment = "--\(endCharCount/50)/\(numberOfSegments)"

            let endCharIndex = announceString.startIndex.advancedBy(endCharCount)
            startCharIndex = announceString.startIndex.advancedBy(endCharCount - 50)
            announceStringSegment += announceString.substringWithRange((startCharIndex...endCharIndex))
            anounceStringHolder = announceString
        }
    }
}
