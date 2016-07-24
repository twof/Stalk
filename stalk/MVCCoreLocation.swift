//
//  MVCExtension.swift
//  stalk
//
//  Created by Clara Hwang on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import CoreLocation
extension MapViewController: CLLocationManagerDelegate{
	
//	func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//		<#code#>
//	}
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		

		if let location = self.locationManager.location
		{
			userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
			userPin.coordinate = userLocation!
			if !haveAddedPin
			{
				mapView.addAnnotation(userPin)
				mapView.addAnnotation(otherPin!)

//				mapView.selectAnnotation(userPin, animated: true)
				mapView.selectAnnotation(otherPin!, animated: true)
				haveAddedPin = true
				
				setUpViewAsRegion(userPin, other: otherPin!)
				
//				setUpViewAsRect(userPin, other: otherPin)
			}
//			for an in mapView.annotations
//			{
//				mapView.selectAnnotation(an, animated: true)
//			}
			print("latitude: \(userLocation!.latitude), longitude: \(userLocation!.longitude)")

		}
		else {
			print("location manager is nil")
		}
	}
	
	
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		print("location manager error: ")
		print(error.description)
	}
	//	func locationManager(locationManager manager: CLLocationManager, didFailWithError error: NSError)
	//	{
	//		print(NSError)
	//	}
}