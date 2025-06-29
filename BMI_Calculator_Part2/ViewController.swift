//
//  ViewController.swift
//  BMI_Calculator_Part2
//
//  Created by Hank Chen on 6/29/25.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var educateMeButton: UIButton!

    var bmiResult: BMI?
    
    struct BMI: Decodable {
        let bmi: Double
        let more: [String]
        let risk : String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        educateMeButton.isEnabled = false
    }
    
    @IBAction func calculateBMI(_ sender: Any) {
        bmiLabel.text = "BMI"
        riskLabel.text = "Label"
        riskLabel.backgroundColor = .clear
        messageLabel.text = "Message"
        educateMeButton.isEnabled = false

        guard let heightStr = heightTextField.text,
              let weightStr = weightTextField.text,
              !heightStr.isEmpty,
              !weightStr.isEmpty else {
            bmiLabel.text = "Error"
            riskLabel.text = "Invalid input"
            riskLabel.backgroundColor = UIColor.red
            messageLabel.text = "Please enter your height and weight"
            return
        }
        
        guard let height = Int(heightStr),
              let weight = Int(weightStr) else {
            bmiLabel.text = "Error"
            riskLabel.text = "Parsing Error"
            riskLabel.backgroundColor = UIColor.red
            messageLabel.text = "The input data couldn't be read"
            return
        }
        
        
        let urlStr = "https://jig2ag6wwdvb52n6jrexlf3n7u0comxh.lambda-url.us-west-2.on.aws?height=\(height)&weight=\(weight)"
        
        guard let url = URL(string: urlStr) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in guard let data = data, error == nil else {
            DispatchQueue.main.async {
                self.bmiLabel.text = "Error"
                self.riskLabel.text = "API Error"
                self.messageLabel.text = "Failed to connect to server"
            }
            return
        }
            
            do {
                let result = try JSONDecoder().decode(BMI.self, from: data)
                self.bmiResult = result
                
                DispatchQueue.main.async {
                    self.riskLabel.text = "                         "
                    self.bmiLabel.text = String(format: "BMI: %.2f", result.bmi)
                    self.messageLabel.text = result.risk
                    
                    switch result.bmi {
                    case ..<18:
                        self.riskLabel.backgroundColor = UIColor.blue
                    case 18..<25:
                        self.riskLabel.backgroundColor = UIColor.green
                    case 25..<30:
                        self.riskLabel.backgroundColor = UIColor.purple
                    default:
                        self.riskLabel.backgroundColor = UIColor.red
                    }
                    
                    self.educateMeButton.isEnabled = !result.more.isEmpty
                }
            } catch {
                DispatchQueue.main.async {
                    self.bmiLabel.text = "Error"
                    self.riskLabel.text = "Parsing Error"
                    self.messageLabel.text = "Failed to parse server data"
                }
            }
        }
        
        task.resume()
    }
    
    @IBAction func educateMe(_ sender: Any) {
        guard let urlStr = bmiResult?.more.first,
              let url = URL(string: urlStr) else {
            messageLabel.text = "cannot access URL"
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
