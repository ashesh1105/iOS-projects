/*
 CurrencyConverter App that calls to grab currencies and display on app.
 
 Needed Security Settings to call a non-secure URL:
 Since we are using a URL with http in it, not https, in order to call the URL, we need to:
 1) Go to info.plist, click + sign and look for attribute: App Transport Security Setting.
 2) Then click on the arrow left of this to make it point downwards, get a sub-attribute called Allow Arbitrary
    Loads. By default value of this will be NO, change that to YES. After this you can call a non-secure URL
    from iPhone apps.
 3) Add label controls on View Controller.
 4) On save button clicked action, notice how the URL is called via a task (async job) that you get from session.dataTask and at the end task.resume is a must for the operation to happen. Check the use of guard let to avoid errors during parsing and extracting data later on from jsonResponse. Notice the use of DispatchQueue.async.main blocks whenever we need to send data (add to label, print error etc., on main thread. It is import whenever you're inside a closure, i.e., async jobs.
 
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var inrLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    @IBAction func getRatesBtnPressed(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing and JSON Serialization
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=7fe2b9b828986f78a50590c25c0466ba")
        
        // Gives a singleton session object
        let session = URLSession.shared
        
        // Closure. Doesn't block main thread
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                // Prepare and present an alert
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                if data != nil {
                    do {
                        // You need to use guard let here to avoid error: "Type 'any' as no subscript members" during extracting data from jsonResponse
                        guard let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        else {
                            DispatchQueue.main.async {
                                print("Error parsing Json Response!")
                            }
                           return
                        }

                        // Async operation
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                                
                                // print rates
                                if let CAD = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(CAD)"
                                }
                                if let CHF = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(CHF)"
                                }
                                if let GBP = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(GBP)"
                                }
                                if let INR = rates["INR"] as? Double {
                                    self.inrLabel.text = "INR: \(INR)"
                                }
                                if let JPY = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(JPY)"
                                }
                                if let USD = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(USD)"
                                }
                                if let TRY = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(TRY)"
                                }
                            }
                        }
                    } catch {
                        print("Error on JSON Serialization.")
                    }

                }

            }
        }
        task.resume()   // Important step! Think of this as Thread.start() in Java
    }
    
}

