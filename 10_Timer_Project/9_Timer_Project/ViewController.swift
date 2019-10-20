//  9_Timer_Project
/*
 This project demonstrates the use of threads via Timer object by displaying countdown from 10 to 0 in a label.
 You'll need pause between counters printed for a human to see it. If you use Thread.sleep(forTimeInterval: 1)
 method in viewDidLoad, that won't work since viewDidLoad runs before view gets loaded so your view won't even
 display on app till all counters come down to 0 and then it will display Timer: 0
 
 If you do same code in viewDidAppear, that will be better but there also since you do this in main thread,
 label won't get updated till for loop is all done and then you'll see Time: 0 on the label.
 
 Hence we need Timer object here instanciated via a method that allows us to say how many times timer runs, on which object, which objectivbe c function to execute and all of that done as another thread, not the main one.
 You do this in viewDidLoad, so before view gets loaded, it displays what you put to label, i.e., Time: 10,
 then it instantiates a new Timer thread which runs in parallel to continue updating the label. When counter
 reaches 0, you invalidate the Timer and the loop finishes.
 
 Note while running this app, you can click on button (or anything else you put on the app) while Timer is doing
 its job!
 */
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    var timer = Timer()
    var counter = 0
    
    // Runs before the view gets loaded, so label timers won't work if you put it in this method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
    }
    
    // Runs after the view gets loaded, so better place to add visible count down timer but there's a catch here!
//    override func viewDidAppear(_ animated: Bool) {
//
//        // Below code blocks current thread so you will see end result as "Time: 0" but not the progress
//        // Best approach in this case will be to run it in a background thread using Timers in viewDidLoad itself, shown above
//        var counter = 10
//        for _ in 1...10 {
//            counter -= 1
//            timeLabel.text = "Time: \(counter)"
//            Thread.sleep(forTimeInterval: 1)
//        }
//    }
    
    // This is the #selector objective c function called by Timer timer for specified number of time
    @objc func timerFunction() {
        timeLabel.text = "Time: \(counter)"
        counter -= 1
        if counter == 0 {
            timer.invalidate()  // Must do this once done with a timer
            timeLabel.text = "Time is over!"
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        print("button clicked!")
        
    }
}

