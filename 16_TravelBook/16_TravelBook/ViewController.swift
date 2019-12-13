/*
 * TravelBook Project
 * Map Kit View is the UI Object we need to use for Maps.
 * On the simulator, this is how you move and zoom around map view:
 * 1) Mouse click and drag moves the map
 * 2) Double click zooms it
 * 3) Shift + Option + single mouse click does the zoom out.
 *
 * Set Region(Location) and Zoom Level (span) for your map. Also, if you want to zoom in, out, move around your map:
 * 1) Define a global variable for locationManager using CLLocationManager class that takes no argument for its constructor.
 * 2) Assign delegate of locationManager to an instance of ViewController class (self)
 * 3) Set desired level of accuracy using .desiredAccuracy property and chose one of the objects as values. Start with "kcl" to see options.
 * 4) Set when you want user to authorize us to use location. requestWhenInUseAuthorization is used in this example.
 * 5) Update info.plist, add declaration for "Privacy - Location When In Use Usage Description" with message you want user to see while requesting them to allow their location.
 * 6) Do locationManager.startUpdatingLocation()
 * 7) Override locationManager method in CLLocationManagerDelegate class that has argument didUpdateLocations locations: [CLLocation] to get locations array. In this function you grab coordinates from first element of location array, create span(zoom level), create Region using MKCoordinateRegion class and finally add the region to map view. This way map gets updated automatically when user zooms in (double +'es on simulator), zooms out (shift + option + single click on simulator) or drags and moves the map.
 *
 * Allow users to add custom tags involves:
 * 1) Using UILongPressGestureRecognizer so when user does long press (not a quick tap) for (configurable) number of seconds, swift calls the #selector function to do rest of the custom tag work there. Pass gesterRecognizer as well in this function.
 * 2) In the function, grab the location from gesterRecognizer, convert to coordinates.
 * 3) Create annotation using MKPointAnnotation class and add coordinated, title and subtitle to annotation.
 * 4) Add the annotation to Map View.
 * 5) If you can have a handle for two fields, name and comments in View Controller, you can use the user entered text to set title and subtitle on custom tag.
 
 * Save Custom Tag to CoreData:
   1) Create Entity called Places and define its attributes as title (String), subtitle(String), latitude(Double), longitude(Double) and id(UUID).
   2) Check ArtBook Project to check the steps we need to save data to CoreData.
   3) For Latitude and Longitude, define global variables like chosenLatitude, chosenLongitude and in choseLocations method, retrieve them from touchPoint (as touchedCoordinates.latitude, etc) and set them. So these two global variables get the new chosen latitude and longitude each time new custom tag is added.
   4) Save the context by do-try-catch block.
 
 * Retrieve Custom Tags from CoreData and Display on the map
   1) Add a new view on Main.storyboard to list available custom locations in table view.
   2) Add a new Cocoa touch file "LocationsListViewController" and associate that with new view added. Make this view as entry point by dragging the right arrow on Main-storyboard from previous view to new one. While selecting new view and Identity Inspector on top right corner does not give you new vie controller swift file in drop down, right click on Main.storyboard -> View As -> Source Code. In the source code for Main.storyboard, ensure customModule and customModuleProvider are there for new customClass "LocationListViewController" as well, like (main) ViewController customClass in same source code:
       <viewController id="kGH-tz-aHA" customClass="LocationListViewController" customModule="_6_TravelBook" customModuleProvider="target" sceneMemberID="viewController">
   3) Add Navigation Controller to the view by Editor -> Embed In -> Navigation Controller. This will enable back button on ViewCotroller View and give you the top navigation bar.
   4) Use Table View as demonstrated in previous apps of this tutorial. Use an array of a custom class Place with attributes like title, subTitle, latitude, longitude, etc. Define an array of this object which will hold the number of places, from which we can display title (and may be subtitle) on a row in this view.
   5) In viewDidLoad method, retrieve the places from CoreData and update the place array, so they can display in table view.
   
  * Save a new place to CoreData
   1) In viewDidLoad, also add the + button on top right navigation bar (see comments with code). Define a function to be called when user clicks on this and there, do the segue to second view. In second view, save the new location with custom annotation tag.
   2) When user saves a new custom tag on second view (ViewController), save the data to CoreData and send a message using NotificationCenter which is observed at viewWillAppear method of LocationListViewController to reload everything from CoreData. This is because viewDidLoad is called only once, so we need to use viewWillAppear for this.
   
  * Finally, check the two prebuilt mapView functions at the end of this class (ViewController) where we display metadata when user clicks on annotation (pin) and also a button there to click to take the user to driving directions of from current location to this place.
 
 */

import UIKit
import MapKit   // To manage maps
import CoreLocation // To manage user locaton
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // When you connect Map Kit View to View Controller, have to do 3 things to avoid the error for not having delegate:
    // 1) import MapKit
    // 2) Make ViewController extend from MKMapViewDelegate
    // 3) In viewDidLoad, declare delegate of mapView object to be an instance of this class (using 'self')
    @IBOutlet weak var mapView: MKMapView!
    
    // Handle to manage user location. Import CoreLocation before this
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var saveBtnOutlet: UIButton!
    
    // Global variables to get coordinates of cuatom location
    var customTagLatitude : Double = 0.0
    var customTagLongitude : Double = 0.0
    var chosenPlace : Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // One of the must do steps before using Map View
        mapView.delegate = self
        
        // Assign delegate. Make sure to have this class extend from CLLocationManagerDelegate before assigning delegate
        locationManager.delegate = self
        
        // Desired level of accuracy on user location. Best accuracy consumes maximum battery. There are other options
        // available. Chose the one that meets your needs wisely. Start typing kcl to see other available options
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // You can go for requestAlwaysAuthorization() or other options available (type .request to see them)
        locationManager.requestWhenInUseAuthorization()
        
        // Before accessing user location, you must go to info.plist, click on + button to add a property, scroll down
        // and select "Privacy - Location When In Use Usage Description". On right side under in value column, provide
        // a good message for users of this app to see
        locationManager.startUpdatingLocation()
        
        // If chosenPlace is not nil, populate text fields with texts
        if (chosenPlace != nil) {
            nameText.text = chosenPlace?.getTitle()
            commentText.text = chosenPlace?.getSubTitle()
            
            // Disable the text buttons and hide save button as user clicks on a place to get to this view
            nameText.isEnabled = false
            commentText.isEnabled = false
            saveBtnOutlet.isHidden = true
            
            // Show annotation on the map based on chosen place
            let annotation = MKPointAnnotation()
            annotation.title = chosenPlace?.getTitle()
            annotation.subtitle = chosenPlace?.getSubTitle()
            let chosenCoordinate = CLLocationCoordinate2D(latitude: chosenPlace?.getLatitude() ?? 0.0, longitude: chosenPlace?.getLongitude() ?? 0.0)
            annotation.coordinate = chosenCoordinate
            self.mapView.addAnnotation(annotation)

            // Update (current) location on map to the chosen one
            locationManager.stopUpdatingLocation()
            updateLocationOnMap(location: chosenCoordinate) // call our custom method            
        } else {
            nameText.text = ""
            commentText.text = ""
        }
        
        // Add Custom Tags on a location
        // We need to add a gester recognizer that waits for few secs on pressed and not just a quick tap. Below variation of Gester Recognizer class helps
        // Note: In this version of Recognizer, you have the pass the gesterRecognizer to #selector function
        let gesterRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(choseLocation(gesterRecognizer:)))
        gesterRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gesterRecognizer)
        
        // Below code ensures that keyboard goes down when user taps at anywhere in the view
        // (Use Cmd + K if you don't see keyboard at all)
        // This helps keyboard not hiding save button, rest of view, etc
        let gesterRecognizerHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesterRecognizerHideKeyboard)
    }
    
    // Add Custom Tag on a location - this is where we define implementation for it
    @objc func choseLocation(gesterRecognizer : UILongPressGestureRecognizer) {
        
        // Location is passed in gesterRecognizer.location object
        let touchPoint = gesterRecognizer.location(in: self.mapView)
        
        // You need to convert location to its coordinates
        let touchedCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        
        customTagLatitude = touchedCoordinates.latitude
        customTagLongitude = touchedCoordinates.longitude
        
        // Pin of that location is called annotation
        let annotation = MKPointAnnotation()
        
        // Give coordinate, title and subtitle to annotation (pin)
        annotation.coordinate = touchedCoordinates
        annotation.title = nameText.text
        annotation.subtitle = commentText.text
        
        // Finally, add the annotation to mapView
        self.mapView.addAnnotation(annotation)
    }
    
    // Save custom tags
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        // We need to reach AppDelegate functions here. For this we will assign a variable for it
        // UIApplication.shared gives singleton instance that this class has
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // We retrieve an NSManagedOobject as below
        let context = appDelegate.persistentContainer.viewContext
        
        // Let's write to our entity "Paintings" now:
        // Import CoreData before using below class NSEntityDescription which describes an entity
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        // We will now add values for the attributes in the entity
        // Check the Places entity at .xcdatamodeld file in your project for attributes
        newPlace.setValue(nameText.text!, forKey: "title")
        newPlace.setValue(commentText.text!, forKey: "subtitle")
        
        // Add latitude and longitude. These global variables get updated whenever choseLocation method is called
        newPlace.setValue(customTagLatitude, forKey: "latitude")
        newPlace.setValue(customTagLongitude, forKey: "longitude")
        
        
        // UUID function gives a unique value each time. Good to use for id
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("Success saving new custom location!")
        } catch {
            print("Error saving new custom location!")
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
    
    // Override this function from CLLocationManagerDelegate that give user locations as an array
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Update location only if new location is to be added and not via selecting a place on previous view
        if chosenPlace == nil {
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            updateLocationOnMap(location: location)
        }
    }
    
    // Custom function to update map to show desired location as current
    func updateLocationOnMap(location: CLLocationCoordinate2D) {
        
        // Define zoom level. Smaller the arguments below will mean higher zoom
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        // Define Region which means where the map will be centered on and how much will be zoom level
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    // Prebuilt function to customize annotation pin so when clicked brings meta data and a button on right
    // The meta data it will display in our case will be title and subtitle
    // MKMapViewDelegate class that we extended, has this prebuilt function. Start typing "viewfor.." for auto complete
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.blue
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    // Here's how we can make the button we added above functioning by using this prebuilt method
    // This basically gives us control to do something when button we added above, is clicked
    // In our case, when user clicks on the button we show driving directions from current location to this one
    // If you extended MKMapViewDelegate, just start typing "calloutaccessory.." to auto complete this
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Closure
        if chosenPlace != nil {
            let requestLocation = CLLocation(latitude: chosenPlace?.getLatitude() ?? 0.00, longitude: chosenPlace?.getLongitude() ?? 0.00)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.chosenPlace?.getTitle()
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        // This will open up driving directions from current location
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }
}

