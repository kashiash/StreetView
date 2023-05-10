//
//  LookAroundView.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 11/05/2023.
//

import Foundation
import SwiftUI
import MapKit

struct LookAroundView: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: MKLookAroundViewController, context: Context) {
        if let tappedLocation {
            Task{
                let scene = await getScene(tappedLocation: .init(latitude: tappedLocation.latitude, longitude: tappedLocation.longitude))
                
                if scene == nil {
                    withAnimation{
                        self.showLookAroundView = false
                    }
                    return
                }
                
                withAnimation {
                    self.showLookAroundView = true
                }
                
                uiViewController.scene = scene
            }
        }
    }
    
   
    typealias UIViewControllerType = MKLookAroundViewController

    @Binding var tappedLocation: CLLocationCoordinate2D?
    @Binding var showLookAroundView: Bool
    
    func makeUIViewController(context: Context) -> MKLookAroundViewController {
        return MKLookAroundViewController()
    }
    
    func getScene(tappedLocation: CLLocationCoordinate2D?) async -> MKLookAroundScene? {
        if let latitude = tappedLocation?.latitude, let longitude = tappedLocation?.longitude {
            let sceneRequest = MKLookAroundSceneRequest(coordinate: .init(latitude: latitude, longitude: longitude))
            
            do {
                return try await sceneRequest.scene
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
