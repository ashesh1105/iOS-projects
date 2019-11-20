/*
 * ArtBook Project
 * This project allows user to upload an image at a time from phone along with meta data around it
 * and save them in CoreData. Saved records are displayed on first view in TableView and second view is
 * used to a) get user inputs (image & meta data), b) display a record when user clicks on a row in first view
 *
 * Details:
 * 1) Create storyboard layout with 2 views, connecting segue between them and getting Navigation Controller by
      using menu: Editor -> Embed in -> Navigation Controller. On First view (ViewController), we get TableView
      and second one (DetailedVC) an ImageView, TextFields for name, artist and year.
 * 2) We go to .xcdatamodeld file and create a new Entity in CoreData: "Paintings" and define its attributes as
      name (String), artist (String), year (Integer 32), image (BinaryData) and id (UUID).
 * 3) We link all the controls to respective view controller. Save Button on DetailedVC needs to be connected
      twice, once as Action, next time as Outlet. Action one is a function where we code on what happens when
      user saves an image, Outlet one is used to show / hide / make button clickable, etc., based on whether we
      are just displaying the image (with meta data), allowing user to capture a new image, has user selected an
      image from phone or not, etc.
 * 4) On View Controler, we add a + button on top right nav by using
      navigationController?.navigationBar.topItem?.rightBarButtonItem. This when clicked, we define a function
      (addButtonClicked) to execute where do perform segue to DetailedVC (take user to another view for inputs)
 * 5) On DetailedVC, we allow imageView to be user action enabled by using isUserInteractionEnabled function and
      add a gesture recognizer to imageView so a function imageViewTapped is called when user taps on imageView.
      In this function we add code for user to see images in phone, select or edit+select an image. Please see
      that function for more details.
 * 6) In DetailedVC, saveBtn (it should've been saveBtnClicked ideally) is the function we defined when user
      clicks on save button. In this function we save an image and related meta data to CoreData. Make sure to
      use do-try-catch block when it comes to saving the context. This function is well documented, please see
      this for coding steps for saving a new record to CoreData. We use this to take the user to first view when
      all done on save button action: self.navigationController?.popViewController(animated: true). Also note
      that when a new record is saved, we need to send a message from saveBtn using
      NotificationCenter.default.post and also add an observer for that named message to be observed in first
      view (ViewController) to reload TableView and display this new record. We add observer inside
      viewWillAppear method (since viewDidLoad is called only once) where we also define a #selector method
      (getData) to be called. CoreData must be imported to use its functions.
 * 7) Inside getData on first view, we retrieve all the records from CoreData and display as rows in TableView
      (just the names of images). Like how we used TableView before, arrays help, we define two arrays, one to
      store names and one for ids. CoreData must be imported to use its functions. ViewControled must implement
      UIViewController, UITableViewDelegate, UITableViewDataSource and same way, DetailedVC must implement /
      extend from UIImagePickerControllerDelegate, UINavigationControllerDelegate.
 * 8) Use overloaded tableView to display rows (records), right content by retrieving from nameArray
 * 9) Allow user to click on a row get to another view (DetailedVC) where we hide save button and display that
      image and meta data. We use tableView method with "didSelectRowAt" argument where we performSegue to
      DetailedVC and in prepare method, make arrangement to pass id and name of the row clicked (similar to
      previous projects).
 * 10) In DetailedVC, viewDidLoad, check if id and name are populated, if so, retrieve that record from CoreData
       and display that. If not, display nothing. If record is available, hide save button and makde text fields
       not editable. Steps to retrieve from CoreData here will be slightly different since we need to also pass
       predicate with NSFetchRequest instance using NSPredicate to say we need record where id is <our id>. We
       can use other fields too but using id is best way.
 * 11) Allow user to swap a row in TableView from right and delete that entry in TableView and CoreData. Like
       before we user tableView method with "editingStyle" argument where we can grab the id for the row swaped
       and delete that from CoreData. Here also we have to use predicate with NSFetchRequest to retrieve the
       right record. Remember, while you can remove the record using context.delete(result) but it won't be
       committed to CoreData until you do context.save()
 * 12) Finally, you can add more images to your phone simulator but using it like actual phone, getting to
       safari browser in it, google for an image, tap on that image and select option "Add to Photos" to save
       the image to your simulator.
 */

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // We want to display metadata of our images records on first view in TableView
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPaitingName = ""
    var selectedPaitingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Below code allows adding an icon on right nav of view controller
        // User clicks on this icon to get to another screen
        // Multiple system icons are available to pick from, like camera, action, etc.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        // Add title to main view controller
        navigationItem.title = "ArtBook Project"
        
        // Fetch Data from CoreData and reload the TableView
        getData()
    }
    
    // We need to add an observer for message "newData" which is posted in second view controller
    // when new image is added to CoreData via default NotificationCenter
    // We can't do this in viewDidLoad method since that executes only once
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    // Here, we will retrieve data from CoreData Database
    @objc func getData() {
        
        // Clear the arrays before reloading the records from CoreData
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Import CoreData before you can use classes in it
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        
        // Below ensures we don't get objects that are faults, manages cache behind the scene more efficiently
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                // You must cast an row as NSManagedObject to use it
                for result in results as! [NSManagedObject] {   // need to cast results from Any to NSManagedObject

                    // Retrieve an attribute from the row (result) and populate nameArray and idArray
                    // We will display these as meta data for CoreData Records on table view of first view
                    if let name = result.value(forKey: "name") as? String {
                        // Note: We need to ensure we use self to refer a variable we want to use from this class
                        self.nameArray.append(name)
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            self.idArray.append(id)
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
    
    @objc func addButtonClicked() {
        selectedPaitingName = ""
        performSegue(withIdentifier: "toDetailedVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaitingName = nameArray[indexPath.row]
        selectedPaitingId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailedVC", sender: nil)   // calls prepare function in turn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailedVC" {
            let destinationVC = segue.destination as! DetailedVC
            destinationVC.chosenPaintingName = selectedPaitingName
            destinationVC.chosenPaintingID = selectedPaitingId
        }
    }
    
    // Add Delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = idArray[indexPath.row].uuidString
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
                            if id == idArray[indexPath.row] {
                                context.delete(result)  // Delete this record from CoreData
                                nameArray.remove(at: indexPath.row) // Remove meta data from local arrays
                                idArray.remove(at: indexPath.row)   // Remove meta data from local arrays
                                self.tableView.reloadData() // Finally, reload the table view
                                
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

