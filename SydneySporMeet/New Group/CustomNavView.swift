//
//  CustomNavView.swift
//  SportMeet
//
//  Created by Niroj Thapa on 3/4/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation
import Foundation
import UIKit
protocol CustomNavigationBarDelegate: class {
    func backbuttonClicked(id : Int)
}

class CustomNavView: UIView
{
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblHeading: UILabel!
    var Customnavdelegate : CustomNavigationBarDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any)
    {
        self.Customnavdelegate.backbuttonClicked(id: 1)
    }
    
    
    private func setupView()
    {
        //Registering the views as nib file
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomNavView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        let image = UIImage(named: "ico_back")?.withRenderingMode(.alwaysTemplate)
        self.btnBack.setImage(image, for: .normal)
        self.btnBack.tintColor = UIColor.black
        //        self.layer.borderWidth = 2
       self.layer.borderColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:nil, views: bindings))
        
    }
}

