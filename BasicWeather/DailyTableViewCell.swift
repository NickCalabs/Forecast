//
//  DailyTableViewCell.swift
//  BasicWeather
//
//  Created by Nick on 2/11/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
