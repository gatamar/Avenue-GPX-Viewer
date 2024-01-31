//
//  MapView.swift
//  Avenue-SwiftUI
//
//  Created by Olha Bachalo on 31/01/2024.
//

import SwiftUI
import MapKit
import CoreGPX

final class MapViewModel: ObservableObject {
    @Published var creator: String = ""
    func loadGPXFile(_ url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        guard let fileGPX = GPXParser(withData: data).parsedData() else {
            return
        }
        creator = fileGPX.creator ?? ""
    }
}

struct MapView: View {
    @State var filename = "Filename"
    @State var showFileChooser = false
    @ObservedObject var viewModel: MapViewModel
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View {
        HStack {
            Text(viewModel.creator)
            Button("select File") {
            let panel = NSOpenPanel()
            panel.allowsMultipleSelection = false
            panel.canChooseDirectories = false
                if panel.runModal() == .OK, let url = panel.url {
                viewModel.loadGPXFile(url)
                self.filename = url.lastPathComponent
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        Map(coordinateRegion: $region)
    }
}

#Preview {
    MapView(viewModel: MapViewModel())
}
