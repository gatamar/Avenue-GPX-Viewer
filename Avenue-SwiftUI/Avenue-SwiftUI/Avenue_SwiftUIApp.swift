//
//  Avenue_SwiftUIApp.swift
//  Avenue-SwiftUI
//
//  Created by Olha Bachalo on 31/01/2024.
//

import SwiftUI

@main
struct Avenue_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(viewModel: MapViewModel())
        }
    }
}
