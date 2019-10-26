//
//  This project demos using models, which are objects to leverage in tableViews.
//  This project is very similar to 12_LandmarkProject except we are using objects here
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var simpsonsArray = [Simpson]()
    
    // Add ? to type to make it optional to avoid error
    // We'll initialize it in tableView method with didSelectRowAt argument
    var selectedSimpson : Simpson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let homer = Simpson(name: "Homer Simpson", job: "Nuclear Safety", image: UIImage(named: "homer")!)
        let marge = Simpson(name: "Marge Simpson", job: "Housewife", image: UIImage(named: "marge")!)
        let bart = Simpson(name: "Bart Simpson", job: "Student", image: UIImage(named: "bart")!)
        let lisa = Simpson(name: "Lisa Simpson", job: "Student", image: UIImage(named: "lisa")!)
        let maggie = Simpson(name: "Maggie Simpson", job: "Baby", image: UIImage(named: "maggie")!)
        
        simpsonsArray = [homer, marge, bart, lisa, maggie]
        
        
        navigationItem.title = "My Landmark Book"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpsonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = simpsonsArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSimpson = simpsonsArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailedVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailedVC" {
            let destinationVC = segue.destination as! DetailedVC
            destinationVC.selectedSimpson = self.selectedSimpson!
        }
    }
}

