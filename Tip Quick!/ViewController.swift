//
//  ViewController.swift
//  Tip Quick!
//
//  Created by user on 5/30/22.
//

import UIKit

class ViewController: UIViewController {
    var bill: Double?
    var tip: Double? = 0
    var persons: Int = 10
    
    @IBOutlet weak var billAmount: UITextField! {
        didSet { billAmount?.addDoneCancelToolbar() }
    }
    
    @IBOutlet weak var zeroTip: UIButton!
    @IBOutlet weak var fiveTip: UIButton!
    @IBOutlet weak var tenTip: UIButton!
    @IBOutlet weak var fifteenTip: UIButton!
    @IBOutlet weak var twentyTip: UIButton!
    @IBOutlet weak var twentyFiveTip: UIButton!
    @IBOutlet weak var personsSplittingLabel: UILabel!
    @IBOutlet weak var personsSplittingSlider: UISlider!
    @IBOutlet weak var eachPayLabel: UILabel!
    @IBOutlet weak var noBillWarning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noBillWarning.isHidden = true
        zeroTip.isSelected = true
    }
    
    func calculateShare() {
        print(tip!)
        bill = Double(billAmount.text!)
        let share = ((bill ?? 0) + ((bill ?? 0) * (tip ?? 0))) / Double(persons)
        let formattedShare = String(format: "%.2f", share)
        eachPayLabel.text = "\(formattedShare) per person"
        if bill == nil {
            noBillWarning.isHidden = false
        } else {
            noBillWarning.isHidden = true
        }
    }
    
    @IBAction func billAmountChanged(_ sender: UITextField) {
        calculateShare()
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

