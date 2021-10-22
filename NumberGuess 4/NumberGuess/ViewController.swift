
import UIKit

class ViewController: UIViewController {
    
    var model = Model()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var guessMeButton: UIButton!
    
    @IBAction func editingTextfield(_ sender: UITextField) {
        guessMeButton.isEnabled = true
        print("text is now\(String(describing: sender.text))")
    }
    
    @IBAction func guessButtonClick(_ sender: UIButton) {
        let guessedNumber = model.compare(guessedString: textField.text!)
        let text:String?
        
        if textField.text == ""{
            guessMeButton.isEnabled = false
        }
        
        switch guessedNumber {
        case -1:
            text = "Zu klein"
        case 1:
            text = "Zu groß"
        default:
            text = "Correct! Tries: \(model.countOfTries)"
            model.numberToGuess = Int.random(in: 0..<100)
            model.countOfTries = 0
            print("Zu erratende Zahl \(model.numberToGuess)")
        }
        
        label.text = text
    }
    
    override func viewDidLoad() {
        guessMeButton.isEnabled = false
        super.viewDidLoad()
        model.numberToGuess = Int.random(in: 0..<100)
        label.text = "Guess now!"
        print("Zu erratende Zahl \(model.numberToGuess)")
    }


}
