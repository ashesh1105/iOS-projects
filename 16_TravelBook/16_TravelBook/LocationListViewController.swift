//
//  Please see ViewController for detailed documentation of this app. This view, LocationListViewController is used to display table view with places, users can click on them to get to detailed view with map of the place and then clicking on the button on annotation, get the driving direction from current location to that place.
//

import UIKit
import CoreData

class LocationListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Save CoreData snapshopt
    var placesArray = [Place]()
    
    // chosen row from TableView
    var selectedPlace : Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add + icon on top right navigation. Calls function addButtonClicked
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))

        // Add title to main view controller
        navigationItem.title = "ArtBook Project"
        
        // Fetch Data from CoreData and reload the TableView
        getData()
    }
    
    // Need it to reload the view with newly saved place on previous view
    override func viewWillAppear(_ animated: Bool) {
        // Add an observer to consume the event passed from previous view when new place is saved
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    // Perform segue, i.e., take user to next view when + button is clicked
    @objc func addButtonClicked() {
        selectedPlace = nil
        performSegue(withIdentifier: "toMapViewController", sender: nil)
    }
    
    // Fetch CoreData Records and refresh the table view
    @objc func getData() {
        
        // Clear the array before reloading the records from CoreData
        placesArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Import CoreData before you can use classes in it
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        
        // Below ensures we don't get objects that are faults, manages cache behind the scene more efficiently
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                // You must cast a row (record) as NSManagedObject to use it
                for result in results as! [NSManagedObject] {   // need to cast results from Any to NSManagedObject

                    // Retrieve an attribute from the row (result) and populate nameArray and idArray
                    // We will display these as meta data for CoreData Records on table view of first view
                    if let newTitle = result.value(forKey: "title") as? String {
                        if let newId = result.value(forKey: "id") as? UUID {
                            if let newSubTitle = result.value(forKey: "subtitle") as? String {
                                if let newLatitude = result.value(forKey: "latitude") as? Double {
                                    if let newLongitude = result.value(forKey: "longitude") as? Double {
                                        
                                        // Create a new Place object and append to placesArray
                                        let newPlace = Place(title: newTitle, subTitle: newSubTitle, latitude: newLatitude, longitude: newLongitude)
                                        newPlace.setId(id: newId)
                                        // Note: We need to ensure we use self to refer a variable we want to use from this class
                                        self.placesArray.append(newPlace)
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    // Reload the TableView each time new record is retrieved
                    tableView.reloadData()
                }
            }
        } catch {
            print("Error fetching records from CoreData DB!")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let displayTitle = placesArray[indexPath.row].getTitle()
        let displaySubTitle = placesArray[indexPath.row].getSubTitle()
        cell.textLabel?.text = "\(displayTitle) - \(displaySubTitle)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = placesArray[indexPath.row]
        performSegue(withIdentifier: "toMapViewController", sender: nil)   // calls prepare function in turn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapViewController" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.chosenPlace = selectedPlace
        }
    }
    
    // Add Delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = placesArray[indexPath.row].getId().uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    // We used id to retrieve record from CoreData. Very likely we results will contain just one
                    // record but since its an array, we should use for loop to iterate through it
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            // Double check if this is same id, since once deleting, data is gone from CoreData
                            if id == placesArray[indexPath.row].getId() {
                                context.delete(result)  // Delete this record from CoreData
                                placesArray.remove(at: indexPath.row) // Remove meta data from local arrays
                                self.tableView.reloadData() // Reload the table view
                                
                                // Finally, you need to save the context for Delete to be successful
                                // This needs another do try catch blocks
                                do {
                                    try context.save()
                                } catch {
                                    print("Error saving context while deleting the row.")
                                }
                                
                                // If using attribute other than id, we should break out of for loop after deleting
                                // If id is used, results will contain one element only, its good practice regardless
                                break
                            }
                        }
                    }
                }
            } catch {
                print("Error deleting the selected record on first view")
            }
        }
    }
}
