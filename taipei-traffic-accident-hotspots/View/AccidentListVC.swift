import UIKit

class AccidentListVC: UIViewController {

    @IBOutlet weak var mTableView: UITableView!

    let viewModel = AccidentListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        viewModel.locations.bind { [weak self] locations in
            self?.mTableView.reloadData()
        }
    }
}

extension AccidentListVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = viewModel.locations.value[indexPath.row].description
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
    
}
