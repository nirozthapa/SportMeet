//
//  ProfileHeaderTableViewCell.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 3/19/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import UIKit
protocol profilePicTappedDelegate:class {
    func changeProfilePic(id : Int)
    
}
class ProfileHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profilePictureView: UIView!
    
    @IBOutlet weak var personName: UILabel!
    var profileDelagate: profilePicTappedDelegate!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        super.awakeFromNib()
        self.imageSetup()
 
    }

    func imageSetup(){
        self.userImage.layer.borderWidth = 0
        self.userImage.layer.masksToBounds = false
        self.userImage.layer.cornerRadius = self.userImage.frame.height/2
        self.userImage.clipsToBounds = true
        self.userImage.contentMode = .scaleAspectFit
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func profilePictureTapped(sender: UITapGestureRecognizer){
        print("User is trying to change the profile picture")
        self.profileDelagate.changeProfilePic(id:1)
        
    }
    
}
