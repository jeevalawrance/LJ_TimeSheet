//
//  TS_TableViewCell.swift
//  TimeSheet
//
//  Created by Jeeva on 12/9/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_TableViewCell: UITableViewCell {

    @IBOutlet weak var lblTaskName: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
