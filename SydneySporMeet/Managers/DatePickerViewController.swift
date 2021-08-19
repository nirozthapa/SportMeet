//
//  DatePickerViewController.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 8/16/21.
//  Copyright © 2021 Niroj Thapa. All rights reserved.
//

import Foundation
import MDatePickerView

import UIKit
import MDatePickerView

protocol DatePickerSelectionDelegate: class {
    func didPickedDate(date: Date, string: String)
}

class DatePickerViewController: PopupViewController {
    
    @IBOutlet weak var datePickerParentView: RoundedView!
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneTapped(_ sender: Any) {
        let selectedDateTuple = self.getSelectedDate()
        selectionDelagate?.didPickedDate(date: selectedDateTuple.date, string: selectedDateTuple.text)
        print("date picked okay",selectedDateTuple.text)
        self.dismiss(animated: true, completion: nil)

    }
    
    var addedYearToCalendar = 0
    
    var datePickerView : MDatePickerView!
    

    weak var selectionDelagate: DatePickerSelectionDelegate?
    var selectedDate: Date! = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializePickerView()
        datePickerView.selectDate = selectedDate
    }
    
    private func createDatePickerView() {
        let mdate = MDatePickerView()
        mdate.delegate = self
        mdate.translatesAutoresizingMaskIntoConstraints = false
        mdate.from = Calendar.current.component(.year, from: Date()) - 1
        mdate.to = Calendar.current.component(.year, from: Date()) + addedYearToCalendar
        datePickerView = mdate
    }
    
    private func initializePickerView() {
        addedYearToCalendar = 0
        createDatePickerView()
        datePickerParentView.addSubview(datePickerView)
        NSLayoutConstraint.activate([
            datePickerView.centerYAnchor.constraint(equalTo: datePickerParentView.centerYAnchor, constant: 0),
            datePickerView.centerXAnchor.constraint(equalTo: datePickerParentView.centerXAnchor, constant: 0),
            datePickerView.widthAnchor.constraint(equalTo: datePickerParentView.widthAnchor, multiplier: 1),
            datePickerView.heightAnchor.constraint(equalTo: datePickerParentView.heightAnchor, multiplier: 1)
        ])
    }

}

extension DatePickerViewController : MDatePickerViewDelegate {
    
    private func getSelectedDate() -> (date: Date, text: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = self.selectedDate!
        let datestr = formatter.string(from: selectedDate)
        return (selectedDate, datestr)
    }
    
    func mdatePickerView(selectDate: Date) {
        let formatter = DateFormatter()
        self.selectedDate = selectDate
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: selectDate)
        print("selected date = \(date)")
    }
}
