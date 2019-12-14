/*
 This project demostrates:
 1) Detecting when user is using Dark Mode.
 2) Making adjustments in app, in this case changing font of a button when Dark Mode is chosen by user.
 3) Best place to make this change, i.e., inside built in function traitCollectionDidChange.
 4) What if we do not want to ignore if user has chosen dark mode and show app the way we want it? It is
    possible. If you want to do it just for one view, do it in viewDidLoad method. If you want to do it in
    entire app, do it in info.plist. Add a row there: User Interface Style with value as Dark or Light
 */

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Since I have added User Interface Style property in info.plist as Dark, changing button font to white
        changeButton.tintColor = UIColor.white
        
        // Use this if you want to override user choice of dark mode, just for this view
        // This also overrides info.plist entry of User Interface Style or Light or Dark for this view!
        // Since below line is uncommented, whatever you added in info.plist will prevail for entire app
//        overrideUserInterfaceStyle = .light
        
    }
    
    /*
     This function is called whenever user changes the "Dark Appearance" setting on or off on iPhone.
     This is the best place to change the font to what you like. Generally app fonts are auto adjusted but
     in this case we are changing the font to white from blue when Dara Appearance is changed to on.
     If you write below code in viewDidLoad, it will change only once. If you do it in viewWillAppear, it will
     not change first time when view loads in an app, it will when you navigate back and forth once from
     one view to another. Using this method helps do it all the time!
     */
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let uiStyle = traitCollection.userInterfaceStyle
        if uiStyle == .dark {
            changeButton.tintColor = UIColor.white
        } else {
            changeButton.tintColor = UIColor.blue
        }
    }

}

