//
//  ExchangeCell.swift
//  AECHelp2
//
//  Created by Kaiqi Fan on 6/23/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit
import Foundation

class ExchangeCell: UITableViewCell,UITextFieldDelegate {

    var onValueModified: (() -> Void)? = nil
    var onStartEditing: (() -> Void)? = nil
    
    @IBOutlet weak var lengthConstraint: NSLayoutConstraint!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var exchangeValue: UITextField!
    
    @IBAction func valuemodify(_ sender: Any) {
        if let onStartEditing = self.onStartEditing {
            onStartEditing()
        }
    }
    // Custom tableViewCell. We have a label here.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.exchangeValue.delegate = self
        
        if exchangeLabel.text == "ºF" {
            exchangeValue.text = "\(32.00)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            return true
        case "-":
            let array = Array(textField.text!.characters)
            
            var minusCount = 0
            for character in array {
                if character == "-" {
                    minusCount += 1
                }
            }
            if minusCount != 1 {
                return true
            } else {
                return false
            }
        case ".":
            let array = Array(textField.text!.characters)
            var decimalCount = 0
            for character in array {
                if character == "." {
                    decimalCount += 1
                }
            }
            
            if decimalCount == 1 {
                return false
            } else {
                return true
            }
        default:
            let array = Array(string.characters)
            if array.count == 0 {
                return true
            }
            return false
        }
    }
    
    @IBAction func valueModified(_ sender: UITextField) {
        if let onValueModified = self.onValueModified {
            onValueModified()
        }
    }
}
