//
//  ProfileMatchViewController.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 3/25/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation
import UIKit
class profileMatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate {
    func backbuttonClicked(id: Int) {
        self.dismiss(animated: true)

    }
    

    
    @IBOutlet weak var custonNavView: CustomNavView!
    
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var btnMatch: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnMatch.backgroundColor = UIColor().getAppButtonColor()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        self.tableVIew.register(UINib(nibName: "ProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderTableViewCell")
        self.tableVIew.isHidden = true
        
        self.custonNavView.Customnavdelegate = self
        self.view.bringSubviewToFront(custonNavView)
        self.custonNavView.lblHeading.text = ""
        self.custonNavView.backgroundColor = UIColor.clear

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableVIew.dequeueReusableCell(withIdentifier: "ProfileHeaderTableViewCell") as! ProfileHeaderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("the index path of the cell is",indexPath.row)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController!
        self.present(viewController!, animated:true, completion:nil)
    }
    
    @IBAction func matchBtnclicked(_ sender: Any) {
        print("User tried to find the matches")
        self.tableVIew.isHidden = false
    }
}
