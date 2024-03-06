import SwiftUI
import CoreLocation
import MapKit


// I literally have no idea how this works. It works though. 
struct LocationPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    @Binding var selectedLocation: String
    
    @StateObject private var locationSearchViewModel = LocationSearchViewModel()
    @State private var query: String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $query, onSearch: {
                    locationSearchViewModel.search(query: query)
                })
                .padding()

                List(locationSearchViewModel.places, id: \.self) { place in
                    Text(place)
                        .onTapGesture {
                            self.selectedLocation = place
                            self.isPresented = false
                        }
                }
            }
            .navigationTitle("Add location")
            .navigationBarItems(leading: Button(action: {
                self.isPresented = false
            }) {
                Text("Cancel")
                    .accentColor(.primary)
            })
        }
    }
}

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var places = [String]()
    private var locationManager = CLLocationManager()
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchRegion: MKCoordinateRegion?

    override init() {
        super.init()
        locationManager.delegate = self
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
        locationManager.requestLocation()
    }

    func search(query: String) {
        searchCompleter.queryFragment = query
    }
}

extension LocationSearchViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            searchRegion = region
            searchCompleter.region = region
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error fetching location: \(error.localizedDescription)")
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let results = completer.results.map { $0.title }
        DispatchQueue.main.async {
            self.places = results
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error fetching results: \(error.localizedDescription)")
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onSearch: () -> Void

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        var onSearch: () -> Void

        init(text: Binding<String>, onSearch: @escaping () -> Void) {
            _text = text
            self.onSearch = onSearch
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            onSearch()
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onSearch: onSearch)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Find a location"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

// Remember to add a LocationPickerView_Previews if needed
