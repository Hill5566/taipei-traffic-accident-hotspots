import UIKit
import MapKit

class AccidentMapVC: UIViewController {

    @IBOutlet weak var mMapView: MKMapView!
    @IBOutlet weak var mCompassButton: UIButton!
    @IBAction func compassClick(_ sender: UIButton) {
        viewModel.lockAtUserLocation.value = true
    }
    
    let locationManager = CLLocationManager()

    let viewModel = AccidentListViewModel()

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
extension AccidentMapVC: CLLocationManagerDelegate {
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = manager.location else { return }
        
        viewModel.userLocation = location
        
        if viewModel.lockAtUserLocation.value {
            moveRegionTo(location)
        }
    }
}

extension AccidentMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if mapViewRegionDidChangeFromUserInteraction() {
            viewModel.lockAtUserLocation.value = false
        }
    }
}
