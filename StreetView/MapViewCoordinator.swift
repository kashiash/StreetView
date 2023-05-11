//
//  MapViewCoordinator.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 11/05/2023.
//

import SwiftUI
import MapKit


class MapViewCoordinator: NSObject,MKMapViewDelegate {
    
    @Binding var tappedLocation: CLLocationCoordinate2D?
    
    var mapViewController : MapView
    
    init(_ mapView:MapView, tappedLocation: Binding<CLLocationCoordinate2D?>) {
        self.mapViewController = mapView
        self._tappedLocation = tappedLocation
    }
    
    @objc func mapTapped(_ sender: UITapGestureRecognizer) {
        
        guard let mapView = sender.view as? MKMapView else { return }
        
        let touchLocation = sender.location(in: sender.view)
        
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: sender.view)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = .init(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        
        self.tappedLocation = locationCoordinate
        
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(annotation)
        
        
    }
}
