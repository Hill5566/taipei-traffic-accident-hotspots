import Foundation
import CoreLocation
import MapKit

class SpeedTrapViewModel {
    
    private lazy var geoCoder = CLGeocoder()

    var userLocation: CLLocation? = nil
    var lockAtUserLocation: Box<Bool> = Box(true)
    var destinationLocation: Box<MKPointAnnotation?> = Box(nil)
    var destinationRoute: Box<MKRoute?> = Box(nil)
    
    let locations: Box<[SpeedTraps]> = Box([])
    
    init() {
        let locationsData = DataConverter.csvToArrray(fileName: "police speed traps", withExtension: "txt")
        var locationsArray:[SpeedTraps] = []
        locationsData.forEach { location in
            locationsArray.append(SpeedTraps(dictionary: location))
        }
        locations.value = locationsArray
//        var locationsArray:[AccidentLocation] = []
//        locationsData.forEach { location in
//            locationsArray.append(AccidentLocation(dictionary: location))
//        }
//        locations.value = locationsArray
        print(locations.value.first?.coordinate)
    }
    
    func naviTo(destination: String) {
        geoCoder.geocodeAddressString(destination) { [weak self] (pls: [CLPlacemark]?, error) -> Void in
            let shPL = pls?.first
//            let circle2 = MKCircle(center: (shPL?.location?.coordinate)!, radius: 0)
//            self.mMapView.addOverlay(circle2)
            
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.title = destination
            annotation.coordinate = (pls?.first?.location?.coordinate)!
            
            self?.destinationLocation.value = annotation
//            self.mMapView.addAnnotation(annotation)
            
            guard let userLocation = self?.userLocation else { return }
            let cl = CLPlacemark(placemark: MKPlacemark(coordinate: userLocation.coordinate))
            self?.getRouteMessage(cl, endCLPL: shPL!)
        }
    }
    
    func getRouteMessage(_ startCLPL: CLPlacemark, endCLPL: CLPlacemark) {
        
        let request: MKDirections.Request = MKDirections.Request()
        
        let sourceMKPL: MKPlacemark = MKPlacemark(placemark: startCLPL)
        request.source = MKMapItem(placemark: sourceMKPL)
        
        let endMKPL: MKPlacemark = MKPlacemark(placemark: endCLPL)
        request.destination = MKMapItem(placemark: endMKPL)
        
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions: MKDirections = MKDirections(request: request)
        
        directions.calculate { [weak self] (response:MKDirections.Response?, error:Error?) in
        
            if let err = error {
                print("MKDirections.calculate err = \(err)")
            }
            if let resp = response {
                print(resp)
                
                for route: MKRoute in resp.routes {
                    
                    self?.destinationRoute.value = route
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

