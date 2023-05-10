//
//  MapView.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 10/05/2023.
//

import Foundation
import UIKit
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var tappedLocation: CLLocationCoordinate2D?
    
    @StateObject var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        
        mapView.showsUserLocation = true
        
        let mapTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(MapViewCoorinator.mapTapped(_:)))
        mapView.addGestureRecognizer(mapTap)
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if uiView.delegate != nil { return }
        
        if let userLocation = locationManager.userLocation{
            uiView.setRegion(.init(center:userLocation,latitudinalMeters: 200,longitudinalMeters: 200), animated:false)
            uiView.delegate = context.coordinator
            
        }
    }
    
    func makeCoordinator() -> MapViewCoorinator {
        MapViewCoorinator(self, tappedLocation: $tappedLocation)
    }
}

class MapViewCoorinator: NSObject,MKMapViewDelegate {
    
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
        
        mapView.removeAnnotation(mapView.annotations)
        mapView.addAnnotation(annotation)
        
        
    }
}
