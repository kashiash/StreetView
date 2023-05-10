//
//  ContentView.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 10/05/2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    @State var tappedLocation: CLLocationCoordinate2D?
    @State var showLookAroundView: Bool = false
    
    @State private var lookAroundViewLocation: CGPoint = .zero
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                MapView(tappedLocation: $tappedLocation)
                LookAroundView(tappedLocation: $tappedLocation, showLookAroundView: $showLookAroundView)
                    .frame(width: .infinity,height: 200)
                    .opacity(showLookAroundView ? 1:0 )
                    .cornerRadius(10)
            }
            .ignoresSafeArea(.all)
        }
    }
    
    var dragGesture: some Gesture {
      DragGesture()
            .onChanged { value in
                self.lookAroundViewLocation = value.location
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
