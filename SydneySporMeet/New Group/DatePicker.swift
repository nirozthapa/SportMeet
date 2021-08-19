//
//  DatePicker.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 4/3/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import UIKit

class DatePicker: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    var datePicker1 : UIDatePicker!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView()
    {
        //Registering the views as nib file
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DatePicker", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        //        self.layer.borderWidth = 2
        //        self.layer.borderColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:nil, views: bindings))
        
    }

}
