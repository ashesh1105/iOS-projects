//
//  DetailedVC.swift
//  Please see documentation @  ViewController.swift for details on this project.
//

import UIKit
import CoreData

class DetailedVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    // We pick outlet for this save button variable, used to enable or disable the save button on view
    // Function saveBtn is created by chosing Action instead of outlet (in below code in this class)
    @IBOutlet weak var saveBtnOutlet: UIButton!
    
    // Chosen Paiting as selected from first view
    var chosenPaintingName = ""
    var chosenPaintingID : UUID?    // make it as optional incase CoreData doen't has matching record
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenPaintingName != "" {
            
            // We are only displaying the image and meta data here, so don't need save button
            // All the text fields can be disabled (non-editable)
            saveBtnOutlet.isHidden = true
            nameText.isEnabled = false
            artistText.isEnabled = false
            yearText.isEnabled = false
            
            // Retrieve record from CoreData and display it on second view
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            // Add predicate so result only gets one record with id we are passing on
            let idString = chosenPaintingID?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)  // regex is used here
            
            fetchRequest.returnsObjectsAsFaults = false;
            
            // do-try-catch block is needed since context.fetch can throw exceptions
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String {
                                artistText.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int {
                                    yearText.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data {
                            // Need to convert Data to an Image using UIImage class
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
                
            } catch {
                print("Error fetching selected image in previous view.")
            }
            
            
        } else {
            // Display empty screen to allow new paiting to be saved
            // Keep Save button disabled till image is picked up
            saveBtnOutlet.isEnabled = false
            nameText.text = ""
            artistText.text = ""
            yearText.text = ""
        }

        // Below code ensures that keyboard goes down when user taps at anywhere in the view
        // (Use Cmd + K if you don't see keyboard at all)
        // This helps keyboard not hiding save button, rest of view, etc
        let gesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesterRecognizer)
        
        // Make imageView tappable and add a recognizer to that
        imageView.isUserInteractionEnabled = true
        let tapGesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesterRecognizer)

    }
    
    @objc func imageViewTapped() {
        
        print("Image Picker Tapped!")

        // This lets us pick an image or movie from library
        let picker = UIImagePickerController()
        
        // For below to work you will have to extend this class from UIImagePickerControllerDelegate
        // and UINavigationControllerDelegate classes. This lets us go back and forth between newly presented
        // picker controller and back. Later on we will use methods in these classes which will define
        // what needs to be done after we select the picture itself
        picker.delegate = self  // we will have to dismiss it later on
        picker.sourceType = .photoLibrary   // you have more Enum types to chose from like camera or album
        picker.allowsEditing = true
        
        // Present this picker, like we did in earlier chapters for alert messages
        // We are chosing nothing to be done in completion here, so going for nil option
        // For iOS version prior to 13, go to info.plist on project folder, chose Privacy - photo library usage
        // description and add the text to persuade user to approve usage of photo library.
        // Not needed for iOS 13 and up
        present(picker, animated: true, completion: nil)
    }
    
    // Now we need to use the methods on classes we extended to tell swift what to be done when image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // info argument is a dictionary that takes one of the enum types as keys like originalImage,
        // editedImage, livePhoto, etc. We are ignoring editing here so going for originalImage as key
        // Since image come as Any type, we need to cast it as image. We are optionally casitng it since
        // user can do mistakes like select a wrong media, etc.
        imageView.image = info[.originalImage] as? UIImage
        
        // Once image is picked, save button can be enabled
        saveBtnOutlet.isEnabled = true
        
        // dismiss picker controller to go back to original view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        // We need to reach AppDelegate functions here. For this we will assign a variable for it
        // UIApplication.shared gives singleton instance that this class has
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // We retrieve an NSManagedOobject as below
        let context = appDelegate.persistentContainer.viewContext
        
        // Let's write to our entity "Paintings" now:
        // Import CoreData before using below class NSEntityDescription which describes an entity
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        // We will now add values for the attributes in the entity
        // Check the Paintings entity at .xcdatamodeld file in your project for attributes
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        
        // year attribute is numeric so we will have to cast it to Integer
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        // UUID function gives a unique value each time. Good to use for id
        newPainting.setValue(UUID(), forKey: "id")
        
        // In order to convert image to DB, we will have to convert it to a binary data first
        // compressionQuality higher will mean better quality images and vice versa
        // iPhones takes pretty good quality pictures these days, so 50% quality will be sufficient
        // We are force unwrapping image which we can ensure no crash by not enabling save button till image
        // is selected. There can be other ways to ensure that
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        // In swift you do: do - try - catch block for code that throws exceptions
        do {
            try context.save()
            print("Success saving painting!")
        } catch {
            print("Error saving painting!")
        }
        
        // When we save a new image on second view, we need to send a message to first view controller
        // So first view loads that data from CoreData and displays it there. We use NotificationCenter for that
        // Here we are using default notification center to post a message to entire app with name as "newData"
        // We will have to have an observer where we need to use this message
        // We will have an observer for this message in first view controller
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
        // Below line will take user to first view controller when an image is saved!
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    

}
