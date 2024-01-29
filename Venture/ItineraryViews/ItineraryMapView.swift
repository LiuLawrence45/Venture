import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize and add the mapView
        mapView = MKMapView(frame: self.view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
        
        // Center the map on a specific location
        let initialLocation = CLLocation(latitude: 37.4275, longitude: -122.1697
)
        mapView.centerToLocation(initialLocation)
        
        // Add annotations to the map
        addAnnotations()
        
        // Set the mapView delegate to self
        mapView.delegate = self
    }
    
    func addAnnotations() {
        let location1 = CLLocationCoordinate2D(latitude: 37.4274, longitude: -122.1670)
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = location1
        annotation1.title = "Location Title"
        annotation1.subtitle = "Location Subtitle"
        mapView.addAnnotation(annotation1)
        
        // Add more annotations as needed...
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "CustomPin"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.image = UIImage(named: "YOUR_CUSTOM_ICON")
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
