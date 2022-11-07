
import CoreLocation
import MapKit


struct Navi {
    
    static var geoCoder = CLGeocoder()

    static func navi(from userLocation:CLLocation ,to destination: String, completionHandler: @escaping (MKPointAnnotation) -> Void) {
        geoCoder.geocodeAddressString(destination) { (pls: [CLPlacemark]?, error) -> Void in
            let shPL = pls?.first
//            let circle2 = MKCircle(center: (shPL?.location?.coordinate)!, radius: 0)
//            self.mMapView.addOverlay(circle2)
            
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.title = "台中"
            annotation.coordinate = (pls?.first?.location?.coordinate)!
            
            completionHandler(annotation)
//            self?.destinationLocation.value = annotation
//            self.mMapView.addAnnotation(annotation)
            
            let cl = CLPlacemark(placemark: MKPlacemark(coordinate: userLocation.coordinate))
            getRouteMessage(cl, endCLPL: shPL!)
        }
    }
    
    static func getRouteMessage(_ startCLPL: CLPlacemark, endCLPL: CLPlacemark) {
        
        let request: MKDirections.Request = MKDirections.Request()
        
        let sourceMKPL: MKPlacemark = MKPlacemark(placemark: startCLPL)
        request.source = MKMapItem(placemark: sourceMKPL)
        
        let endMKPL: MKPlacemark = MKPlacemark(placemark: endCLPL)
        request.destination = MKMapItem(placemark: endMKPL)
        
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions: MKDirections = MKDirections(request: request)
        
        directions.calculate { (response:MKDirections.Response?, error:Error?) in
        
            if let err = error {
                print("MKDirections.calculate err = \(err)")
            }
            if let resp = response {
                print(resp)
                
                for route: MKRoute in resp.routes {
                    
//                    self?.destinationRoute.value = route
//                    self.mMapView.addOverlay(route.polyline)
//                    self.mMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)

                    print(route.advisoryNotices)
                    print(route.name, route.distance, route.expectedTravelTime)

                    for step in route.steps {
                        print(step.instructions, step.distance)
                    }
                }
            }
        }
    }

    
}
