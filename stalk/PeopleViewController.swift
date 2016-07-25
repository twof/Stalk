//
//  ViewController.swift
//  Sonar
//
//  Created by Aleš Kocur on 01/01/16.
//  Copyright © 2016 Aleš Kocur. All rights reserved.
//

import UIKit
import CoreLocation
import Sonar
import MapKit
import SwiftyJSON

class PeopleViewController: UIViewController,SonarViewDelegate,SonarViewDataSource, CLLocationManagerDelegate {
    @IBOutlet weak var sonarView: SonarView!
    private lazy var distanceFormatter: MKDistanceFormatter = MKDistanceFormatter()
    
    struct AnnounceSegment {
        var value: String
        var index: Int
        
    }
    
    struct AnnounceString {
        var segments = [AnnounceSegment]()
        var totalSegments: Int
        var fullString: String? {
            var s = ""
            
            for a in segments{
                s += a.value
            }
            return s
            
        }
        mutating func addToSegments(segment: AnnounceSegment)
        {
            var i = 0
            for a in segments{
                if segment.index > a.index {
                    segments.insert(segment, atIndex: i+1)
                    return
                }
                i += 1
            }
        }
    }
    var userStrings: [AnnounceString] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        PPKController.enableWithConfiguration(APP_KEY, observer:self)
        PPKController.enableProximityRanging()
        // Do any additional setup after loading the view, typically from a nib.
        self.sonarView.delegate = self
        self.sonarView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool){
        sonarView.reloadData()
    }
    @IBAction func refresh(sender: AnyObject) {
        sonarView.reloadData()
    }
    

    func sonarView(sonarView: SonarView, didSelectObjectInWave waveIndex: Int, atIndex: Int) {
        print("Did select item in wave \(waveIndex) at index \(atIndex)")
        self.performSegueWithIdentifier("toPerson", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="toPerson"{
            let vc = segue.destinationViewController as! MapViewController
            //photo, name, level, location
        }
    }
    
    func sonarView(sonarView: SonarView, textForWaveAtIndex waveIndex: Int) -> String? {
        if self.sonarView(sonarView, numberOfItemForWaveIndex: waveIndex) % 2 == 0 {
            return self.distanceFormatter.stringFromDistance(100.0 * Double(waveIndex + 1))
        } else {
            return nil
        }
    }
    func numberOfWaves(sonarView: SonarView) -> Int {
        return 3
    }
    
    func sonarView(sonarView: SonarView, numberOfItemForWaveIndex waveIndex: Int) -> Int {
        switch waveIndex {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 3
        default:
            return 2
        }
    }
    
    func sonarView(sonarView: SonarView, itemViewForWave waveIndex: Int, atIndex: Int) -> SonarItemView {
        let itemView = self.newItemView()
        itemView.imageView.image = randomAvatar()
        itemView.label.text = "MC"
        return itemView
    }
    
    // MARK: - Helpers
    
    private func randomAvatar() -> UIImage {
        
        return UIImage(named: "avatar2")!
    }
    
    private func newItemView() -> TestSonarItemView {
        return NSBundle.mainBundle().loadNibNamed("TestSonarItemView", owner: self, options: nil).first as! TestSonarItemView
    }

}

extension PeopleViewController: PPKControllerDelegate{
    func PPKControllerInitialized() {
        // ready to start discovering nearbys
        let myDiscoveryInfo = "Hello from Swift!, Hey Justin!".dataUsingEncoding(NSUTF8StringEncoding)
        print(NSString(data: myDiscoveryInfo!, encoding: NSUTF8StringEncoding)!)
        PPKController.startP2PDiscoveryWithDiscoveryInfo(myDiscoveryInfo, stateRestoration: false)
        P2PHelper.constructAnnounceString()
        print(P2PHelper.anounceStringHolder)
    }
    
    func p2pPeerDiscovered(peer: PPKPeer!) {
        let discoveryInfoString = NSString(data: peer.discoveryInfo, encoding:NSUTF8StringEncoding)
        NSLog("%@ is here with discovery info: %@", peer.peerID, discoveryInfoString!)
        
        if let dataFromString = peer.discoveryInfo{
            print(discoveryInfoString)
            let newString = discoveryInfoString?.substringFromIndex(2)
            let val = Int((newString?.substringToIndex((newString?.startIndex.advancedBy(1))!))!)
            let oString = discoveryInfoString?.substringFromIndex(4)
            let end = Int((oString?.substringToIndex((newString?.startIndex.advancedBy(1))!))!)
            
            let valueS = discoveryInfoString?.substringFromIndex(5)
            let s = PeopleViewController.AnnounceSegment(value: valueS!, index: val!)
            if val != 1 {
                userStrings[0].addToSegments(s)
            }
            else
            {
                let json = JSON(data: )
                
                PeerHelper.addNewPeerToList(Peer(json: json))

                userStrings = []
                userStrings.append((valueS!,(val)!,(end)!))
            }
            
            
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
    
    private func removeAndReturnSegmentOrder(segment: String) -> AnnounceSegment{
        var index: Range<String.Index>
        var indexSubstring: String
        var segmentOrder: Int
        var valueSubstring: String
        
        if segment.lowercaseString.rangeOfString("--") != nil {
            index = segment.lowercaseString.rangeOfString("--")!
            valueSubstring = segment.substringWithRange(segment.startIndex...index.startIndex)
            indexSubstring = segment.substringWithRange(index.endIndex...segment.endIndex)
        }
        
        if indexSubstring.lowercaseString.rangeOfString("/") != nil {
            index = indexSubstring.lowercaseString.rangeOfString("/")!
            segmentOrder = Int(indexSubstring.substringWithRange(indexSubstring.startIndex...index.endIndex))!
        }
        
        return AnnounceSegment(value: valueSubstring, index: segmentOrder)
    }
}


func delay(delay: Double, closure: Void -> Void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
}


