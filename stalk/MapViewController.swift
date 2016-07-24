//
//  MapViewController.swift
//  stalk
//
//  Created by Clara Hwang on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {
	@IBOutlet weak var mapView: MKMapView!
	
	var userLocation: CLLocationCoordinate2D?
	
	var otherLocation: CLLocationCoordinate2D? = nil //If these three are not set, it will fail
	var otherLevel: Int? = nil
	var otherName: String? = nil
	
	var userPin = PinLocation(title: "Here you are!")
	var otherPin: PinLocation? = nil

	let locationManager = CLLocationManager()
	var timer = NSTimer()
	var haveAddedPin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        otherName = "justin"
        otherLevel = 3
        otherLocation = CLLocationCoordinate2D(latitude: 37, longitude: -122)
//        otherPin = PinLocation(title: "hi", coordinate: <#T##CLLocationCoordinate2D#>, level: 3)
        // Do any additional setup after loading the view.
		mapView.delegate = self
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestAlwaysAuthorization()
		locationManager.startUpdatingLocation()
		haveAddedPin = false
		
		updateOther()
//		updateMapWithTimeIntervalInSeconds(1)

    }

	func updateOther()
	{
		if let name = otherName
		{
			otherPin = PinLocation(title: name, coordinate: otherLocation!, level: otherLevel!)
		}

	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
//	func updateMapWithTimeIntervalInSeconds(seconds: Double){
//		// Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
//		timer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: #selector(MapViewController.updateMap), userInfo: nil, repeats: true)
//	}
//	
//	func updateMap()
//	{
//		
//	}
}
