//
//  SignUpTableViewController.swift
//  SportMeet
//
//  Created by Niroj Thapa on 3/2/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class SingUpTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate,UITextFieldDelegate{
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavView: CustomNavView!
    @IBOutlet weak var embededPickerView: UIView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    var dateString : String!
    var selectedIndexPath: IndexPath?
    var timeSetup: String!
    var pickerInt = 5
    var refData: DatabaseReference!

    let states = [ "NSW","QLD","SA","TAS","VIC","WA" ]

    let cellData = ["test","Email","Password","ConfirmPassword"]
   
    var userEmail: String?
    var password: String?
    var confirmPassword: String?
    
    override func viewDidLoad() {
        
        //register the nib files
        tableView.register(UINib(nibName: "CustomNameLabelCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomNameLabelCellTableViewCell")
        tableView.register(UINib(nibName: "SignUpTableViewHeaderCell", bundle: nil), forCellReuseIdentifier: "SignUpTableViewHeaderCell")
        tableView.register(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "DatePickerTableViewCell")
        tableView.register(UINib(nibName: "labelWithButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "labelWithButtonTableViewCell")
        tableView.register(UINib(nibName: "UIPickerTableViewCell", bundle: nil), forCellReuseIdentifier: "UIPickerTableViewCell")


        
        //related to table views
        tableView.delegate = self
        tableView.dataSource = self
        self.customNavView.Customnavdelegate = self
        self.view.bringSubviewToFront(customNavView)
        self.customNavView.lblHeading.text = ""
        self.tableView.backgroundColor = UIColor.clear
        //view.backgroundColor = UIColor().getAppBackgroundColor()
        //tableView.backgroundColor = UIColor().getAppBackgroundColor()
        self.tableView.rowHeight = 80
        self.tableView.separatorColor = UIColor.clear
        
        //dealing with navigationbar

        //Pickerviews
        datePickerView.isHidden = true
        embededPickerView.isHidden = true
        
        //adding gesture or hiding keyboiards and date
        
//        cell.btnSelect.addTarget(self, action:#selector(handleRegister(sender:)), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideEveryViews(sender:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells {
            if cell.isKind(of: UIPickerTableViewCell.self) {
                (cell  as! UIPickerTableViewCell).ignoreFrameChanges()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tblViewHeight?.constant = self.tableView.contentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count + 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.row == 0){

            let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpTableViewHeaderCell") as! SignUpTableViewHeaderCell
            return cell
        }
            
//        else if(indexPath.row == 6){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "labelWithButtonTableViewCell") as! labelWithButtonTableViewCell
//
//            cell.lblTitle.text = "Date of Birth"
//            cell.backgroundColor = UIColor.white
//            cell.btnSelect.backgroundColor = UIColor().getAppButtonColor()
//            cell.btnSelect.setTitleColor(UIColor().getAppTextColor(), for: .normal)
//            cell.btnSelect.addTarget(self, action:#selector(handleRegister(sender:)), for: .touchUpInside)
//            if(dateString != nil){
//                cell.btnSelect.setTitle(dateString, for: .normal)
//            }
//            else{
//                cell.btnSelect.setTitle("Select date", for: .normal)
//
//            }
//            return cell
//        }
//
        else if(indexPath.row == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelWithButtonTableViewCell") as! labelWithButtonTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.lblTitle.text = ""
            cell.btnSelect.backgroundColor = UIColor().getAppButtonColor()
            cell.btnSelect.setTitle("SignUp", for: .normal)
            cell.btnSelect.setTitleColor(UIColor().getAppTextColor(), for: .normal)
            cell.btnSelect.addTarget(self, action:#selector(SignUp(sender:)), for: .touchUpInside)


            return cell

        }
//        else if(indexPath.row == pickerInt){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "UIPickerTableViewCell") as! UIPickerTableViewCell
//
//            // indexPath Check
//            // indexPath Check
//            if indexPath != selectedIndexPath {
//                if let timeSetup = timeSetup {
//                    cell.txt_pickUpData.text = timeSetup
//                    print("\(timeSetup)")
//                }
//            } else {
//                // initialize value to default one.
//                cell.minutes = self.states
//                cell.txt_pickUpData.text = "select your state"
//
//            }
//            let tap = UITapGestureRecognizer(target: self,
//                                                    action: #selector(PickerCell(sender:)))
//            cell.txt_pickUpData.addGestureRecognizer(tap)
//           return cell
//        }

        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNameLabelCellTableViewCell") as! CustomNameLabelCellTableViewCell
              cell.inputField.delegate = self
            cell.inputField.tag = indexPath.row
            cell.lblName.text = cellData[indexPath.row]
            if(indexPath.row == 4 || indexPath.row == 3){
                cell.inputField.keyboardType = .numberPad
            }
            return cell
        }
    }
    
    @objc func PickerCell(sender: UITapGestureRecognizer){
        let indexPath = IndexPath(row: pickerInt, section: 0)

        if(indexPath.row == pickerInt){
            let previousIndexPath = selectedIndexPath
            
            if indexPath == selectedIndexPath {
                selectedIndexPath = nil
            } else {
                selectedIndexPath = indexPath
            }
            
            var indexPaths: Array<IndexPath> = []
            if let previous = previousIndexPath {
                indexPaths += [previous]
            }
            if let current = selectedIndexPath {
                indexPaths += [current]
            }
            
            if indexPaths.count > 0 {
                tableView.reloadRows(at: indexPaths, with: UITableView.RowAnimation.automatic)
            }
        }
        
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 200;
        }
        else if (indexPath.row == pickerInt && indexPath == selectedIndexPath ) {
            return UIPickerTableViewCell.expandedHeight
        } else {
            return  80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello world")
        if(indexPath.row == pickerInt){
            let previousIndexPath = selectedIndexPath
            
            if indexPath == selectedIndexPath {
                selectedIndexPath = indexPath
                
            } else {
                selectedIndexPath = indexPath
            }
            
            var indexPaths: Array<IndexPath> = []
            if let previous = previousIndexPath {
                indexPaths += [previous]
            }
            if let current = selectedIndexPath {
                indexPaths += [current]
            }
            
            if indexPaths.count > 0 {
                tableView.reloadRows(at: indexPaths, with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    // observer
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == pickerInt){
            
            (cell as! UIPickerTableViewCell).watchFrameChanges()
        }
        
        self.viewWillLayoutSubviews()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            userEmail = textField.text
        }
        else if textField.tag == 2 {
            password = textField.text
        }
        else if textField.tag == 3 {
            confirmPassword = textField.text
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.tableView) == true {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == pickerInt){
            (cell as! UIPickerTableViewCell).ignoreFrameChanges()
        }
    }
    

    
    @objc func handleRegister(sender: UIButton){
        datePickerView.isHidden = false
        embededPickerView.isHidden = false
        view.endEditing(true)

    }
    
    @objc func SignUp(sender:UIButton){
        datePickerView.isHidden = true
        embededPickerView.isHidden = true
        
        guard let signupEmail = self.userEmail, let pass = self.password, let confirmPass = self.confirmPassword, pass == confirmPass else {
            debugPrint("Invalid signup state")
            return
        }
        let authUser = AuthUser()
        authUser.email = signupEmail
        authUser.password = pass
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        UIApplication.shared.beginIgnoringInteractionEvents()
        SignupManager().signupUser(user: authUser) { [weak self] (data, err) in
            if let error = err {
                debugPrint(("Error: \(error.localizedDescription)"))
            }
            else {
                if let isSuccess = data as? Bool, isSuccess {
                    self?.showHome()
                }
                else {
                    debugPrint("Error: K bhayo hernu parcha...!!!")
                }
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIApplication.shared.endIgnoringInteractionEvents()
        }
//        let newBookRef = Database.database().reference().child("UserProfile").childByAutoId()
//        let mydata = Database.database().reference().child("UserProfile")
//        //let key = details.key
//        let uservalues = ["id":"nirojthapa557@gmail.com","email":"nirojthapa556@gmail.com","Password":"98601421"]
//        //check if value exists in database
//        mydata.observeSingleEvent(of: .value, with: { (snap : DataSnapshot)  in
//            for child in snap.children {
//                let key = (child as AnyObject).key as String
//
//            }
//        }) { (err: Error) in
//            print("\(err.localizedDescription)")
//        }

            
        //newBookRef.setValue(uservalues)
    }
    
    private func showHome() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileTabVC") as? ProfileTabbarController
        let transition = CATransition()
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        transition.duration = 0.3
        initialViewController?.view.layer.add(transition, forKey: nil)
        appDelegate.window?.rootViewController = initialViewController
    }
    
    @IBAction func selectDatePicker(_ sender: Any) {
        
        datePickerView.isHidden = true
        embededPickerView.isHidden = true
        self.dateString = dateToString(date: datePickerView.date)
        let indexPath = IndexPath(row: 6, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        print(picker.date)
    }
    func dateToString(date: Date)-> String{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
        
    }
    
    @objc func hideEveryViews(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        datePickerView.isHidden = false
        embededPickerView.isHidden = true

    }
    
    func backbuttonClicked(id: Int) {
        self.dismiss(animated: true)
    }
    

}
