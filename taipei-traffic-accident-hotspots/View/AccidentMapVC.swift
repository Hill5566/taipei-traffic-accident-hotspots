import UIKit
import MapKit

class AccidentMapVC: UIViewController {

    @IBOutlet weak var mMapView: MKMapView!
    
    let viewModel = AccidentListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.locations.bind { [weak self] locations in
            self?.mMapView.addAnnotations(locations)
        }
    }


}
