//
//  MapView.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 10/05/2023.
//


import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var tappedLocation: CLLocationCoordinate2D?
    
    @StateObject var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        
        mapView.showsUserLocation = true
        
        let mapTap = UITapGestureRecognizer(target: context.coordinator,
                                            action: #selector(MapViewCoordinator.mapTapped(_:)))
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
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self, tappedLocation: $tappedLocation)
    }
}

