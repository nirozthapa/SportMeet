//
//  UserSportDetailsTableViewCell.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 3/27/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import UIKit

class UserSportDetailsTableViewCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            if((tableView == self.mysportTableView)){
                return 2
            }
            else if((tableView == self.sportTableView)){
                return 2
            }
            return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if((tableView == self.mysportTableView)){
        let cell = self.mysportTableView.dequeueReusableCell(withIdentifier: "ProfileHeaderTableViewCell") as! ProfileHeaderTableViewCell
        return cell
        }
        else if((tableView == self.sportTableView)){
            let cell = self.sportTableView.dequeueReusableCell(withIdentifier: "ProfileHeaderTableViewCell") as! ProfileHeaderTableViewCell
            return cell
        }

        return UITableViewCell()
        
//        let cell = self.mysportTableView.dequeueReusableCell(withIdentifier: "ProfileHeaderTableViewCell") as! ProfileHeaderTableViewCell
//                return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
  
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.contentView.setNeedsLayout()
//        cell.contentView.layoutIfNeeded()
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBOutlet weak var sportTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mySportTblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var sportTableView: UITableView!
    @IBOutlet weak var mysportTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.sportTableView.delegate = self
        self.mysportTableView.delegate = self
        
        self.sportTableView.dataSource = self
        self.mysportTableView.dataSource = self
        
        self.sportTableView.register(UINib(nibName: "ProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderTableViewCell")
        self.mysportTableView.register(UINib(nibName: "ProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderTableViewCell")
        sportTableView.backgroundColor = UIColor.red
    }
    

//    override func layoutSubviews() {
//        self.mySportTblViewHeight.constant = self.sportTableView.contentSize.height
//        mysportTableView.frame.size = mysportTableView.contentSize
//    }

    override func layoutSubviews(){
        
        self.sportTableViewHeight.constant  = self.mysportTableView.contentSize.height
        self.sportTableView.setNeedsLayout()
        self.sportTableView.layoutIfNeeded()
        
        self.sportTableView.reloadData()

    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
