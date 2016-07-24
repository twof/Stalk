//
//  ViewController.swift
//  stalk
//
//  Created by JAEHYUN SIM on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import UIKit


class ViewController: UIViewController, PPKControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        PPKController.enableWithConfiguration(APP_KEY, observer:self)
        PPKController.enableProximityRanging()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    func p2pPeerLost(peer: PPKPeer!) {
        NSLog("%@ is no longer here", peer.peerID)
    }
    
    func discoveryInfoUpdatedForPeer(peer: PPKPeer!) {
        let discoveryInfo = NSString(data: peer.discoveryInfo, encoding: NSUTF8StringEncoding)
        NSLog("%@ has updated discovery info: %@", peer.peerID, discoveryInfo!)
        let myDiscoveryInfo = "Hello again!".dataUsingEncoding(NSUTF8StringEncoding)
        PPKController.pushNewP2PDiscoveryInfo(myDiscoveryInfo)

    }
    
    func proximityStrengthChangedForPeer(peer: PPKPeer!) {
        if (peer.proximityStrength.rawValue > PPKProximityStrength.Weak.rawValue) {
            NSLog("%@ is in range, do something with it", peer.peerID);
        }
        else {
            NSLog("%@ is not yet in range", peer.peerID);
        }
    }
}


