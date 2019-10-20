//
// This project demostrates use of UITableView.
// Whenever you work with UITableView, some steps are necessary:
// 1) Make ViewController class use methods of UITableViewDelegate and UITableViewDataSource class
// 2) Above will make you override 2 tableView overloaded functions:
//   A) One where you return row count so that many rows get displayed on the view,
//   B) Other one where you return the contents for rows. Here, an argument indexPath.row can be used
//      as index if you have the contents coming via custom arrays like landmarkNames.
// 3) You can leverage more overloaded functions coming out of UITableView classes like the one
//    with argument UITableViewCell.EditingStyle which you can use to allow deletes by swapping
//    rows. Another one with argument didSelectRowAt indexPath: IndexPath can be used to perform
//    an action (like do segue to another view controller when user taps on a row.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var landmarkNames = [String]()
    var landmarkImages = [UIImage]()
    
    var chosenLandmarkNames = ""
    var chosenLandmarkImages = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Below is necessary for this view controller to use the defined tableView
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // Populate the two global arrays defined with strings and images
        landmarkNames.append("Colosseum")
        landmarkNames.append("Great Wall")
        landmarkNames.append("Kremlin")
        landmarkNames.append("Stonehenge")
        landmarkNames.append("Taj Mahal")
        
        // Ensure image names match with images assets imported to project
        landmarkImages.append(UIImage(named: "colosseum.jpg")!)
        landmarkImages.append(UIImage(named: "great-wall-china.jpg")!)
        landmarkImages.append(UIImage(named: "Kremlin.jpg")!)
        landmarkImages.append(UIImage(named: "stonehenge.jpg")!)
        landmarkImages.append(UIImage(named: "taj_mahal.jpg")!)
        
        // This is how you can set title for your page. You will see this on next view controller too as back link text!
        navigationItem.title = "My Landmark Book"
    }

    // Below UITableViewDataSource function returns number of rows dislayed on table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    // In the function below, indexPath.row represents int value from 0 to number of rows - 1 (returned from above function
    // Hence argument indexPath.row can be used to populate table rows from elements of our array landmarkNames
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = landmarkNames[indexPath.row]
        return cell
    }
    
    // If we want to allow users to swipe tableView rows and delete them (for example), we need to use below
    // method from UITableViewDelegate. Along with our custom arrays, we need to delete data from tableView as well
    // where we need to chose the style of deletion. We chose fade as one way it will show when a row is gone
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            landmarkNames.remove(at: indexPath.row)
            landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    // Specifies what happens when user selects one of the rows in tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenLandmarkNames = landmarkNames[indexPath.row]
        chosenLandmarkImages = landmarkImages[indexPath.row]
        
        // Check 6_SegueApp project to know more about segue between two view controllers
        // toDetailedViewController is the identifier name between two view controllers
        performSegue(withIdentifier: "toDetailedViewController", sender: nil)
        
    }
    
    // Check 6_SegueApp project to know more about segue between two view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailedViewController" {
            let destinationVC = segue.destination as! DetailedViewController
            destinationVC.selectedLandmarkName = chosenLandmarkNames
            destinationVC.selectedLandmarkImage = chosenLandmarkImages
        }
    }

}

