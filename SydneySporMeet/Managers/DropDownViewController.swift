//
//  DropDownViewController.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 8/18/21.
//  Copyright © 2021 Niroj Thapa. All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown
import IQKeyboardManagerSwift
protocol DropDownSelectionDelegate:class {
    func selectedItem(selectedItemName: String,selectedItemId:Int,senderTag:Int)
    
}
class DropDownViewController:PopupViewController{
    @IBOutlet weak var dropDown: DropDown!
    weak var dropdownDelegate:DropDownSelectionDelegate?
    var dropDownClass = DropDown()
    var dropDownitem = [String]()
    var senderTag : Int?
    var hideDelegate: DropDownCustomClass?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.DropDownSelection()
        self.dropDown.delegate = self
        

    }
    
    func DropDownSelection(){
        // The list of array to display. Can be changed dynamically
        dropDown.optionArray = self.dropDownitem
        dropDown.optionIds = [1,23,54,22]
        // The the Closure returns Selected Index and String
        dropDown.didSelect{(selectedText , index ,id) in
            self.dropdownDelegate?.selectedItem(selectedItemName: selectedText, selectedItemId: index, senderTag: self.senderTag!)
        }
    }
}
extension DropDownViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
////       // IQKeyboardManager.shared.enableAutoToolbar = false
//        self.dropDown.inputView = UIView.init(frame: CGRect.zero)
//        self.dropDown.inputAccessoryView = UIView.init(frame: CGRect.zero)
//        self.dropDown.isSearchEnable = true

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.dismiss(animated: false, completion: nil)
    }
}
