//import MapKit
//import SwiftUI
//
//
//struct ItineraryMapView: View {
//    
//    let startPosition = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.7600, longitude: -122.446),
//            span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
//        )
//    )
//     
//    
//    @State private var locations = [
//        Location(id: UUID(), name: "📍 Basa Seafood Express in Mission District", description: "Fresh seafood market and restaurant in San Francisco's Mission District.", latitude: 37.7599, longitude: -122.4194),
//        Location(id: UUID(), name: "📍 Catching Sunset @ Twin Peaks", description: "Iconic spot in San Francisco for panoramic city views and sunsets.", latitude: 37.7544, longitude: -122.4477),
//        Location(id: UUID(), name: "📍 Bingsu and Boba @ Sweetheart Cafe", description: "Cozy spot for a variety of boba tea and bingsu.", latitude: 37.7652, longitude: -122.4715)
//    ]
// 
//
//    
//    
//    
//    var body: some View {
//        MapReader { proxy in
//            Map(initialPosition: startPosition) {
//                ForEach(locations) { location in
//                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
//                }
//            }
////            .onTapGesture { position in
////                if let coordinate = proxy.convert(position, from: .local){
////                    let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
////                    locations.append(newLocation)
////                }
////            }
//        }
//    }
//    
//    
//}
//
//
//
//
//
//#Preview {
//    ItineraryMapView()
//}
