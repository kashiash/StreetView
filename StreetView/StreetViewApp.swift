//
//  StreetViewApp.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 10/05/2023.
//

import SwiftUI

@main
struct StreetViewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
