import UIKit
import MapKit

class SpeedTrapVC: UIViewController {

    @IBOutlet weak var mMapView: MKMapView!
    @IBOutlet weak var mCompassButton: UIButton!
    @IBAction func compassClick(_ sender: UIButton) {
        viewModel.lockAtUserLocation.value = true
    }
    
    private let locationManager = CLLocationManager()
    private lazy var viewModel = SpeedTrapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel.locations.bind { [weak self] locations in
            self?.mMapView.addAnnotations(locations)
        }
        viewModel.lockAtUserLocation.bind { [weak self] lock in
            print(lock)
            self?.mCompassButton.isSelected = lock
            if lock, let userLocation = self?.viewModel.userLocation {
                self?.moveRegionTo(userLocation)
            }
        }
        
        viewModel.destinationLocation.bind { [weak self] annotation in
            guard let self = self, let annotation = annotation else { return }
            self.mMapView.addAnnotation(annotation)
        }
        
        viewModel.destinationRoute.bind { [weak self] route in
            guard let self = self, let route = route else { return }
            self.mMapView.addOverlay(route.polyline)
            self.mMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        
        viewModel.naviTo(destination: "台中")
        
        mMapView.userTrackingMode = .follow
        mMapView.delegate = self

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func moveRegionTo(_ location: CLLocation) {
        mMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), latitudinalMeters: 200, longitudinalMeters: 200)
    }
    
    private func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = mMapView.subviews[0]
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if recognizer.state == UIGestureRecognizer.State.began || recognizer.state == UIGestureRecognizer.State.ended {
                    return true
                }
            }
        }
        return false
    }
}
    
extension SpeedTrapVC: CLLocationManagerDelegate {
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = manager.location else { return }
        
        viewModel.userLocation = location
        
        if viewModel.lockAtUserLocation.value {
            moveRegionTo(location)
        }
    }
}

extension SpeedTrapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if mapViewRegionDidChangeFromUserInteraction() {
            viewModel.lockAtUserLocation.value = false
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        var resultRender = MKOverlayRenderer()
        
        if overlay is MKPolyline {
            
            let render: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
            
            render.lineWidth = 4
            render.strokeColor = .systemBlue
            
            resultRender = render
            
        } else if overlay is MKCircle {

            let circleRender: MKCircleRenderer = MKCircleRenderer(overlay: overlay)
            
            circleRender.fillColor = .lightGray
            circleRender.alpha = 0.3
            circleRender.strokeColor = .blue
            circleRender.lineWidth = 2
            
            resultRender = circleRender
        }
        return resultRender
    }
}
