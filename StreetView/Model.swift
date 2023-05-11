//
//  Model.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 11/05/2023.
//

import Foundation
import CoreLocation
import MapKit


class ContentViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published private(set) var results: Array<AddressResult> = []
    @Published var searchableText = ""
    
    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    } ()
    
    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return }
        localSearchCompleter.queryFragment = searchableText
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            results = completer.results.map {
                AddressResult(title: $0.title, subtitle: $0.subtitle)
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}

struct AddressResult: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

extension AddressResult {
     static var example = AddressResult(title: "Instytut im. Lecha i Jrosława. Muzeum dziedzictwa", subtitle: "Warszawa Mickiewicza 51")
}

struct AnnotationItem: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate:CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
