import MapKit
import SwiftUI


struct ItineraryMapView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.4277, longitude: -122.1701),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    var body: some View {
        Map(initialPosition: startPosition)
    }
}



#Preview {
    ItineraryMapView()
}
