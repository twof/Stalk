//
//  PinLocation.swift
//  stalk
//
//  Created by Clara Hwang on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import Foundation
import MapKit

class PinLocation: NSObject, MKAnnotation {
	let title: String?
	var level: Int?
	var subtitle: String? { return "Level \(level)"}
	dynamic var coordinate: CLLocationCoordinate2D
	
	init(title: String, coordinate: CLLocationCoordinate2D, level: Int) {
		self.title = title
		self.coordinate = coordinate
		self.level = level
		super.init()
	}
	
	init(title: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.coordinate = coordinate
		
		super.init()
	}
	init(title: String) {
		self.title = title
		self.coordinate = CLLocationCoordinate2D()
		
		super.init()
	}
	override init() {
		self.title = ""
		self.coordinate = CLLocationCoordinate2D()
		
		super.init()
	}
	
	
	
}