//
//  ChecklistCell.swift
//  AECHelp2
//
//  Created by Kaiqi Fan on 6/23/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit
import Foundation

class ChecklistCell: UITableViewCell {

    @IBOutlet weak var checklistLabel: UILabel!
    
    // Custom tableViewCell. We have a label here.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
