//
//  ProfileViewController.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 3/19/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseDatabase
import Firebase
import IQKeyboardManagerSwift
class ProfileViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,CustomNavigationBarDelegate{
    
    var refData: DatabaseReference!
    @IBOutlet weak var customNavView: CustomNavView!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    let imagePicker = UIImagePickerController()
    var profileImage = UIImage()
    let picker : UIDatePicker = UIDatePicker()
    var dateString : String!
    var dropDownItem: String!
    
    
    var  userDetails =  User()
    
    var name: String?
    var emailAddress : String?
    var phoneNumber : Int?
    var postalCode: Int?
    var locationForExercise: String?
    var state: String?
    var interestedIn : [String]?
    
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
            let image = info[.originalImage] as? UIImage
            self.imageView.image = image
            
            
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //registering nibs
        table.register(UINib(nibName: "ProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderTableViewCell")
        table.register(UINib(nibName: "CustomNameLabelCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomNameLabelCellTableViewCell")
        table.register(UINib(nibName: "labelWithButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "labelWithButtonTableViewCell")
        definesPresentationContext = true
        
        self.customNavView.Customnavdelegate = self
        self.view.bringSubviewToFront(customNavView)
        self.customNavView.lblHeading.text = ""
        
        
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        self.imageSetup()
        //self.table.isHidden = true
        
        
    }
    
    
    func imageSetup(){
        self.imageView.layer.borderWidth = 0
        self.imageView.layer.masksToBounds = false
        self.imageView.layer.cornerRadius = self.imageView.frame.height/2
        self.imageView.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(profilePictureTapped(sender:)))
        tap.delegate = self
        self.imageContainerView.addGestureRecognizer(tap)
    }
    
    @objc func profilePictureTapped(sender: UITapGestureRecognizer){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
    func backbuttonClicked(id: Int) {
        self.dismiss(animated: true)
    }
    
    @objc func openPicker(sender:UIButton){
        switch sender.tag {
        case 5:
            let datePickerVC = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
            datePickerVC.modalPresentationStyle = .overCurrentContext
            datePickerVC.modalPresentationStyle = .overFullScreen
            datePickerVC.shouldAddFullOverlay = true
            datePickerVC.shouldDismissViewOnTapOutside = true
            datePickerVC.selectionDelagate = self
            self.present(datePickerVC, animated: true, completion: nil)
            break
        case 6,7:
            let dropDownVC = self.storyboard?.instantiateViewController(withIdentifier: "DropDownViewController") as! DropDownViewController
            dropDownVC.modalPresentationStyle = .overCurrentContext
            dropDownVC.senderTag = sender.tag
            dropDownVC.dropDownitem = self.selectValuesForDropDown(tag: sender.tag)
            dropDownVC.modalPresentationStyle = .overFullScreen
            dropDownVC.shouldAddFullOverlay = true
            dropDownVC.shouldDismissViewOnTapOutside = true
            dropDownVC.dropdownDelegate = self
            self.present(dropDownVC, animated: true, completion: nil)
            break
            
        default:
            break
        }
        
    }
    
    
    func selectValuesForDropDown(tag:Int) -> [String]{
        switch tag {
        case 6:
            return states
            
        case 7:
            return sports
            
        default:
            print("unidentified tag")
        }
        return ["not verified"]
    }
    
    @objc func SignUp(sender: UIButton){
        self.view.endEditing(true)
        
        let newBookRef = Database.database().reference().child("UserName").childByAutoId()
        let key = newBookRef.key
        let uservalues = ["id":key,"firstName":"myan","email":"nirojthapa556@gmail.com","phoneNumber":"98601421"]
        newBookRef.setValue(uservalues)
        
        //        let newBookRef = self.refData.database.reference()
        //            .child("Books")
        //            .childByAutoId()
        //        let key = newBookRef.key
        //        let uservalues = ["id":key,"firstName":"myan","email":"nirojthapa556@gmail.com","phoneNumber":"98601421"]
        //        newBookRef.setValue(uservalues)
        
    }
    //Action for singup Button clicked
    
    
}


extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellLabels = ["Your Name","Email Address","Phone number","PostalCode","Location for exercise"]
        let nextlabel = ["Date of birth","State","InterestedIn"]
        
        switch indexPath.row {
        case 0,1,2,3,4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNameLabelCellTableViewCell") as!CustomNameLabelCellTableViewCell
            cell.lblName.text =  cellLabels[indexPath.row]
            return cell
        case 5,6,7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelWithButtonTableViewCell") as! labelWithButtonTableViewCell
            cell.lblTitle.text = nextlabel[indexPath.row - 5]
            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.backgroundColor = UIColor.blue
            cell.btnSelect.addTarget(self, action:#selector(openPicker(sender:)), for: .touchUpInside)
            if(indexPath.row == 5){
                cell.btnSelect.setTitle(dateString, for: .normal)
            }
            
            if(indexPath.row == 6){
                cell.btnSelect.setTitle(dropDownItem, for: .normal)
            }
            
            if(indexPath.row == 7){
                cell.btnSelect.setTitle(dropDownItem, for: .normal)
            }
            
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelWithButtonTableViewCell") as! labelWithButtonTableViewCell
            cell.lblTitle.text = "SignUp"
            cell.btnSelect.backgroundColor = UIColor.blue
            cell.btnSelect.addTarget(self, action:#selector(SignUp(sender:)), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
}

extension ProfileViewController: DatePickerSelectionDelegate {
    func didPickedDate(date: Date, string: String) {
        self.dateString = string
        let indexPath = IndexPath(row: 5, section: 0)
        self.table.reloadRows(at: [indexPath], with: .none)
    }
}

extension ProfileViewController:DropDownSelectionDelegate{
    
    
    func selectedItem(selectedItemName: String, selectedItemId: Int, senderTag: Int) {
        self.dropDownItem = selectedItemName
        let indexPath = IndexPath(row: senderTag, section: 0)
        self.table.reloadRows(at: [indexPath], with: .none)
        
    }
    
    
}


