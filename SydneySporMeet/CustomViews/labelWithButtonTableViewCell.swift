//
//  labelWithButtonTableViewCell.swift
//  SportMeet
//
//  Created by Niroj Thapa on 3/4/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import UIKit

class labelWithButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSelectClicked(_ sender: Any) {
        print("Button clicked")
        
    }
    
}
