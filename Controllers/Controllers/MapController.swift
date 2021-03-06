//
//  MapController.swift
//  Relief
//
//  Created by Dylan Slade on 4/14/16.
//  Copyright © 2016 Relief Group. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MapController: NSObject {
    
    var currentAnnotation: MKAnnotation?
    var currentOverlay: MKOverlay?
    
    var delegate: MapUpdating
    
    init(delegate: MapUpdating) {
        self.delegate = delegate
        super.init()
        
        if let initialLocationCoordinate = LocationController.sharedInstance.coreLocationManager.location {
            delegate.centerMapOnLocation(initialLocationCoordinate)
        }
    }
    
    // MARK: - Helper Methods
    
    func addEventToMap(event: Event) {
        let latitude = event.latitude
        let longitude = event.longitude
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = event.title
        annotation.subtitle = event.type
        
        let circle = MKCircle(centerCoordinate: location.coordinate, radius: 1000)
        delegate.addEventOnMap(circle, annotation: annotation)
    }
}

protocol MapUpdating {
    var mapView: MKMapView! { get }
    var navigationController: UINavigationController? { get }
    
    func centerMapOnLocation(location: CLLocation)
    func addEventOnMap(circle: MKCircle, annotation: MKPointAnnotation)
    
    func removeAnnotation(annotation:MKAnnotation, overlay: MKOverlay)
    
}

extension MapUpdating {
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 3.0, regionRadius * 3.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addEventOnMap(circle: MKCircle, annotation: MKPointAnnotation) {
        mapView.addOverlay(circle)
        mapView.addAnnotation(annotation)
    }
    
    func removeAnnotation(annotation:MKAnnotation, overlay: MKOverlay) {
        mapView.removeAnnotation(annotation)
        mapView.removeOverlay(overlay)
    }
    
    
}

func ==(lhs: MapController, rhs: MapController) -> Bool {
    return true
}



