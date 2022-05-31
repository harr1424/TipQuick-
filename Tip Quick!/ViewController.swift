//
//  ViewController.swift
//  Tip Quick!
//
//  Created by user on 5/30/22.
//

import UIKit

class ViewController: UIViewController {
    var bill: Double?
    var tip: Double?
    var persons: Int = 10
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var zeroTip: UIButton!
    @IBOutlet weak var fiveTip: UIButton!
    @IBOutlet weak var tenTip: UIButton!
    @IBOutlet weak var fifteenTip: UIButton!
    @IBOutlet weak var twentyTip: UIButton!
    @IBOutlet weak var twentyFiveTip: UIButton!
    @IBOutlet weak var personsSplittingLabel: UILabel!
    @IBOutlet weak var personsSplittingSlider: UISlider!
    @IBOutlet weak var eachPayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zeroTip.isSelected = true
    }
    
    func calculateShare() {
        if Double(billAmount.text!) == nil {
            let alert = UIAlertController(title: "No Bill Amount", message: "Please enter the amount shown on your bill at the top of the screen", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(alert, animated: true, completion: nil)
        } else {
            bill = Double(billAmount.text!)
            let share = (bill! + (bill! * (tip ?? 0))) / Double(persons)
            let formattedShare = String(format: "%.2f", share)
            eachPayLabel.text = "\(formattedShare) per person"
        }
    }
    
    @IBAction func sliderUpdate(_ sender: UISlider) {
        persons = Int(sender.value)
        personsSplittingLabel.text = "\(persons) Persons Splitting"
        calculateShare()
    }
    
    @IBAction func tipUpdate(_ sender: UIButton) {
        // un-select all tip amount buttons
        zeroTip.isSelected = false
        fiveTip.isSelected = false
        tenTip.isSelected = false
        fifteenTip.isSelected = false
        twentyTip.isSelected = false
        twentyFiveTip.isSelected = false
        
        // select tim amount most recently chosen by yser
        sender.isSelected = true
        
        // convert button title to double and update tip variable
        let tipAsString = sender.currentTitle
        let tipAsNumericString = tipAsString!.dropLast()
        let tipAsDouble = Double(tipAsNumericString)
        tip = tipAsDouble! / 100
        billAmount.endEditing(true)
        calculateShare()
    }
}

