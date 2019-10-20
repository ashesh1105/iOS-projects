//
// This game demonstrates a lot of concepts learned in lessons 1-9 so far!
// There are 9 kenny images, when user clicks on them, score increases. If last score was
// higher than highScore, game persists that as new highScore. During the game kennies
// display themselves one at a time. There are two timers used in this game: 1 to increment
// the time counter, which is countdown from 10 to 1 when game stops, 2nd timer is to
// manage the kennies time interval of showing one at a time. When countdown comes to 0,
// user sees an alert with options as OK or Replay. With OK, game stops for good and needs
// playing agin from the app, with Replay, game restarts with score reset, highScore stays
// as the highest score in the game ever played across sessions so far.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    var score = 0
    var highScore = 0
    var timer = Timer() // manages count down
    var hideTimer = Timer()
    var counter = 0
    let MAX_COUNTER = 10
    
     // Define kennies
     @IBOutlet weak var timeLabel: UILabel!
     @IBOutlet weak var scoreLabel: UILabel!
     @IBOutlet weak var highScoreLabel: UILabel!
     @IBOutlet weak var kenny1: UIImageView!
     @IBOutlet weak var kenny2: UIImageView!
     @IBOutlet weak var kenny3: UIImageView!
     @IBOutlet weak var kenny4: UIImageView!
     @IBOutlet weak var kenny5: UIImageView!
     @IBOutlet weak var kenny6: UIImageView!
     @IBOutlet weak var kenny7: UIImageView!
     @IBOutlet weak var kenny8: UIImageView!
     @IBOutlet weak var kenny9: UIImageView!
    
    // Define an array of type as UIImageView to store all the kennies in it before view gets loaded
    var kenniesArr = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the score, start with 0
        scoreLabel.text = "Score: \(score)"
        
        // Retrieve highScore from light weight key-value store - UserDefaults
        let scoredHighScore = UserDefaults.standard.object(forKey: "high_score")
        
        // If persisted highScore was nil, set highScore to 0
        if scoredHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        // Use if-let to ensure persisted highScore was not nil and an Int
        if let newHighScore = scoredHighScore as? Int {
            highScore = newHighScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        // Ensure Image Views are user action enabled
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        // Create 9 Gesture Recognizers
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        
        // Add recognizers to Image Views
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        // Populate the array with all the kennies.
        // Don't do kenniesArr.append() since that wil take one element at a time. Not very efficient.
        kenniesArr = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        // Set the counter to MAX_COUNTER and start displaying that
        counter = MAX_COUNTER
        timeLabel.text = String(counter)
        
        // Hide all the kennies except one on initial view load
        showOneKennyAtATime()
        
        // Initiate timer to:
        // 1) display count down
        // 2) show one kenny at a time
        // 3) when countdown gets to 0, show alerts to replay or cancel the game
        initiateTimers()
    }
    
    // increments user score in one session and displays it
    @objc func incrementScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    // Displays only one kenny at a time
    @objc func showOneKennyAtATime() {

        // Hide all the kennies to start with
        for kenny in kenniesArr {
            kenny.isHidden = true
        }
        
        // Pick a random number for index of a kenny in kenniesArr and make that visible
        let random = Int(arc4random_uniform(UInt32(kenniesArr.count)))
        kenniesArr[random].isHidden = false
    }
    
    // The two timers we need for various purposes
    func initiateTimers() {
        
        // Countdown timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        // Show / hide kennies
        hideTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(showOneKennyAtATime), userInfo: nil, repeats: true)
    }
    
    // Copuntdown function. Persists highScore. Also manages alerts
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            // Hide all the kennies when games need to reset
            for kenny in kenniesArr {
                kenny.isHidden = true
            }
            
            // Set highScore if previous game brought it any higher
            if score > highScore {
                highScore = score
                highScoreLabel.text = "High Score: \(highScore)"
                // Persist this in lightweight key-value store
                UserDefaults.standard.set(self.highScore, forKey: "high_score")
            }
            
            // Set alerts
            let alert = UIAlertController(title: "Time's up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                // Code here
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = self.MAX_COUNTER
                self.timeLabel.text = String(self.counter)
                self.initiateTimers()
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }


}

