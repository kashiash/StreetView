//
//  MapView2.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 11/05/2023.
//

import SwiftUI
import MapKit


struct MapView2: View {
    @StateObject  var viewModel = MapViewModel()
    
    private let address: AddressResult
    
    init(address: AddressResult){
        self.address = address
    }
    var body: some View {
        Map(coordinateRegion: $viewModel.region,
            annotationItems: viewModel.annotationItems,
            annotationContent: { item in
            MapMarker(coordinate: item.coordinate)
            
        }
        
        )
        .onAppear{
            self.viewModel.getPlace(from: address)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MapView2_Previews: PreviewProvider {
    static var previews: some View {
        MapView2(address: AddressResult.example)
    }
}
