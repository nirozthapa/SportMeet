//
//  LoginViewController.swift
//  SportMeet
//
//  Created by Niroj Thapa on 3/2/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var appLogoView: UIView!
    @IBOutlet weak var appUserNameView: UIView!
    @IBOutlet weak var lblUserName: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //added background colors
//        appLogoView.backgroundColor = UIColor().getAppBackgroundColor()
//        appUserNameView.backgroundColor = UIColor().getAppBackgroundColor()
//        btnLogin.backgroundColor = UIColor().getAppButtonColor()
        btnLogin.setTitleColor(UIColor().getAppTextColor(), for: .normal)
        
        
        //hides keyboard when touched in the view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapInView(sender:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    //hides tap on view
    @objc func tapInView(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    //button actions
    @IBAction func btnLoginClicked(_ sender: Any) {
        print("Button login is clicked")
        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileTabVC") as! ProfileTabbarController
        self.navigationController?.pushViewController(profileViewController, animated: true)

        //self.present(profileViewController, animated:true, completion:nil)
    }
    
    @IBAction func btnSignupClicked(_ sender: Any) {
        print("Button signup is clicked")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SingUpTableViewController") as! SingUpTableViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    
    


}

