//
//  MVCMapKit.swift
//  stalk
//
//  Created by Clara Hwang on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
	
	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		if let annotation = annotation as? PinLocation
		{
			let identifier = "pin"
			var view: MKPinAnnotationView
			if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
				as? MKPinAnnotationView { // 2
				dequeuedView.annotation = annotation
				view = dequeuedView
			} else {
				// 3
				view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
				view.canShowCallout = true
				view.calloutOffset = CGPoint(x: -5, y: 5)
				//view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
			}
			return view
		}
		return nil
	}
	
	func regionFromTwoLocations(userLocation: MKAnnotation, other: MKAnnotation) -> MKCoordinateRegion
	{
		var locationSpan = MKCoordinateSpan()
		locationSpan.latitudeDelta = abs(userLocation.coordinate.latitude - other.coordinate.latitude) * 1.4
		locationSpan.longitudeDelta = abs(userLocation.coordinate.longitude - other.coordinate.longitude) * 1.4
		
		var locationCenter = CLLocationCoordinate2D()
		locationCenter.latitude = (userLocation.coordinate.latitude + other.coordinate.latitude) / 2
		locationCenter.longitude = (userLocation.coordinate.longitude + other.coordinate.longitude) / 2
		
		let region = MKCoordinateRegionMake(locationCenter, locationSpan);
		return region;
	}
//	func rectFromTwoLocations(userLocation: MKAnnotation, other: MKAnnotation) -> MKMapRect
//	{
//		let userPoint = MKMapPointForCoordinate(userLocation.coordinate)
//		let otherPoint = MKMapPointForCoordinate(other.coordinate)
//		
//	
//		var locationSize = MKMapSize()
//		locationSize.height = abs(userPoint.y - otherPoint.y)
//		locationSize.width = abs(userPoint.x - otherPoint.x)
//		
//		
//		var locationPoint = MKMapPoint()
//		
//		locationPoint.x = (userPoint.x + otherPoint.x - locationSize.width) / 2
//		locationPoint.y = (userPoint.y + otherPoint.y - locationSize.height) / 2
//
//		let rect = MKMapRect(origin: locationPoint, size: locationSize)
//		return rect
//	}
	func setUpView(annotation: MKAnnotation, areaInMeters: Double)
	{
		let r = MKCoordinateRegionMakeWithDistance(annotation.coordinate, areaInMeters, areaInMeters)
		mapView.region = r
	}
	func setUpViewAsRegion(annotation: MKAnnotation, other: MKAnnotation)
	{
		mapView.setRegion(regionFromTwoLocations(annotation, other: other), animated: true)
	}
//	func setUpViewAsRect(annotation: MKAnnotation, other: MKAnnotation)
//	{
////		mapView.mapRectThatFits(rectFromTwoLocations(annotation, other: other))
//		mapView.visibleMapRect = rectFromTwoLocations(annotation, other: other)
//	}
}