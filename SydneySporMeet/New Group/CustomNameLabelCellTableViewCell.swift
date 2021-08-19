//
//  CustomNameLabelCellTableViewCell.swift
//  SportMeet
//
//  Created by Niroj Thapa on 3/2/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import UIKit

class CustomNameLabelCellTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var inputField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
