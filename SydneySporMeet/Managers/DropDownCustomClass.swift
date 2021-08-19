//
//  DropDownCustomClass.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 8/18/21.
//  Copyright © 2021 Niroj Thapa. All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown
import IQKeyboardManagerSwift

protocol hideKeyBoardOnDropDown:class {
    func hideKeyboard()
}
class DropDownCustomClass: DropDown {
       weak var keyboardHideDelegate: hideKeyBoardOnDropDown?
    
    func viewDidLoad(){
          self.keyboardHideDelegate?.hideKeyboard()
    }
    

    
}
