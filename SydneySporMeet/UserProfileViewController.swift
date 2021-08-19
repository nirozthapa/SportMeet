//
//  UserProfileViewController.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 3/26/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation
import UIKit
class UserProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.profileTableVIew.dequeueReusableCell(withIdentifier: "UserSportDetailsTableViewCell.") as! UserSportDetailsTableViewCell
//        return cell
        if(indexPath.row == 0){
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSportDetailsTableViewCell") as! UserSportDetailsTableViewCell
        return cell
        }
        else{
            let messageCell  = self.profileTableVIew.dequeueReusableCell(withIdentifier: "labelWithButtonTableViewCell") as! labelWithButtonTableViewCell
            messageCell.lblTitle.isHidden = true
            messageCell.btnSelect.backgroundColor = UIColor().getAppButtonColor()
            messageCell.btnSelect.setTitle("Message", for: .normal)
            messageCell.btnSelect.setTitleColor(UIColor.white, for: .normal)
//            messageCell.btnSelect.frame = CGRect(x: 20, y:20, width: messageCell.frame.size.width / 4, height: 70)
            return messageCell
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 1){
            return 80
        }
        return  UITableView.automaticDimension
    }
    
    func backbuttonClicked(id: Int) {
        self.dismiss(animated: true)

    }
    
    @IBOutlet weak var profileTableVIew: UITableView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var CustomNavView: CustomNavView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("User profile view controller is loaded")
        self.makeCircularImage()
        self.CustomNavView.lblHeading.text = ""
        self.CustomNavView.backgroundColor = UIColor.clear
    self.profileTableVIew.delegate = self
        self.profileTableVIew.dataSource = self
        profileTableVIew.register(UINib(nibName: "UserSportDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "UserSportDetailsTableViewCell")
      profileTableVIew.register(UINib(nibName: "labelWithButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "labelWithButtonTableViewCell")
      self.profileTableVIew.translatesAutoresizingMaskIntoConstraints = true
    }
    
    override func viewWillLayoutSubviews() {
        self.profileTableVIew.frame.size = self.profileTableVIew.contentSize
    }
    
    
    //handle circcular image events
    
    func makeCircularImage() {
        let image = UIImage(named: "applogo")
        self.imageView.image = image
        self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
        self.imageView.clipsToBounds = true
        self.imageView.isUserInteractionEnabled = false
        self.imageView.layer.masksToBounds = true
       
    }
}
