//
//  DatePickerTableViewCell.swift
//  SportMeet
//
//  Created by Niroj Thapa on 3/4/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var datePickerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var datePicker: UIButton!
    @IBOutlet weak var doneBtnView: UIView!
    var datePicker1 = UIDatePicker()
    override func awakeFromNib() {
        super.awakeFromNib()
        doneBtnView.isHidden = true
        datePickerView.isHidden = true

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnDone(_ sender: Any) {
        datePicker.isHidden = false
        datePickerView.isHidden = true
        doneBtnView.isHidden = true
        let selectedDate = dateToString(date: datePickerView.date)
        datePicker.setTitle(selectedDate, for: .normal)
    }
    @IBAction func btncancel(_ sender: Any) {
        datePicker.isHidden = false
        datePickerView.isHidden = true
        doneBtnView.isHidden = true
        let selectedDate = dateToString(date: datePickerView.date)
        datePicker.setTitle(selectedDate, for: .normal)

    }
    @IBAction func datePickerClicked(_ sender: Any) {
        datePicker.isHidden = true
        datePickerView.isHidden = false
        doneBtnView.isHidden = false
    
    }
    
    func dateToString(date: Date)-> String{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
        
    }
   
  
}
