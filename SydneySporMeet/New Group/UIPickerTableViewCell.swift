//
//  UIPickerTableViewCell.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 3/15/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import UIKit

class UIPickerTableViewCell: UITableViewCell,UIPickerViewDelegate,UIPickerViewDataSource {
    var timeSetup: String!
  
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txt_pickUpData: UITextField!
    
    @IBOutlet weak var lblPickerTitile: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    //set tableView height
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var btnDone: UIButton!
    // variable
    var isObserving = false
    var minutes = [String]()
    
    // initialize pickerView delegate, dataSource
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
//        pickerView.showsSelectionIndicator = true
//
//        
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: "donePicker")
//        
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        mainView.addSubview(toolBar)
//
//        toolBar.isUserInteractionEnabled = true
//        txt_pickUpData.inputView = pickerView
//        txt_pickUpData.inputAccessoryView = toolBar
        
      
        
    }
    
    @objc func donePicker(sender:Any){
        print("Hello world")
        print("The selected value is",minutes[self.pickerView.selectedRow(inComponent: 0)])
        
        
    }
    
    // tableViewCell's height setup
    class var expandedHeight: CGFloat { get { return 200 } }
    class var defaultheight: CGFloat { get { return 44 } }
    
    func checkHeight() {
        pickerView.isHidden = (frame.height < UIPickerTableViewCell.expandedHeight)
    }
    
    
    // for pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minutes.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        var titleData = ""
        titleData = "\(minutes[row])"
        pickerLabel.text = titleData
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width / 3
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return minutes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedText = minutes[row]
        self.timeSetup = selectedText//self.lblPickerTitile.text
        txt_pickUpData.text = minutes[row]

        print(selectedText)
    }
    
    // set observer for expanding
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true;
        }
    }
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
            
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }

    
}
