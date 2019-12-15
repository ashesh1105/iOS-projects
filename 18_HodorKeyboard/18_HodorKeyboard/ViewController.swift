/*
 HodorKeyboard: Demonstrates how to use a custom keyboard in iOS apps.
 Special thing about Hodor character in Game of Thrones is, it can just say: Hodor
 In this project when user taps on keyboard, it will say Hodor
 
 In order to enable a custom keyboard:
 1) Import an image in project - hodor.jpeg
 2) Select main project -> File -> New -> Target -> select Custom Keyboard Extension. Next window, preovide a name to custom keyboad we want to use ("Hodor") and Finish.
 3) You'll see a new folder in your project now called "Hodor". Inside, you'll see KeyboardViewController.swift file. Also, you'll see (and make sure Hodor extension is selected to be run as simulator on top right bar.
 4) If you try to run the app her, it will ask you the app to run. Say, if you chose Safari, it will open a Safari browser in app. Clicking on top bar opens up the keyboard. Try switching the keyboard by world icon at bottom left in keyboard, you won't see Hodor keyboard there. Minimize the browser, go to Settings -> General -> Keyboard -> Add new keyboard and you can select Hodor there. Now if you go back to Safari, you should be able to switch to Hodor keyboard! It will, off-course not have any keys there since we haven't written any code yet :)
 5) Inside KeyboardViewController.swift, you'll see code coming by default. Add a new button in viewDidLoad and set its meta data. See comments inline in this file itself for details.
 6) Once you add new button in step 5 above, now if you run the app again with Safari, you can tap on world icon on keyboard to get to Hodor keyboard and you should see the Hodor image there! Clicking on it will print "Hodor Tapped" in XCode console but you need more than that. See next step for that.
 7) To make our new button, simply create a textDocumentProxy object and cast it as UITextDocumentProxy. Then use insertText method on this object to the text you want this button to print. In our case we went with "HODOR!". Now if you run the app as Safari, you can see hodor button printing "HODOR!" on browser URL text area.
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

