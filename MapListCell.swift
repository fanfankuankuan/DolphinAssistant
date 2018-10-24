//
//  MapListCell.swift
//  Help
//
//  Created by Kaiqi Fan on 6/1/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import Foundation
import UIKit



class MapListCellModule: UITableViewCell {
    
    // Custom tableViewCell. We have a label here.
    @IBOutlet weak var mapLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
