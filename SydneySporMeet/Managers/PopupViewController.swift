//
//  PopupViewController.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 8/16/21.
//  Copyright © 2021 Niroj Thapa. All rights reserved.
//

import Foundation
import UIKit

protocol PopupViewDismissDelegate: class {
    func didDismissPopupView()
}

class PopupViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var shouldAddFullOverlay: Bool = false
    var shouldDismissViewOnTapOutside: Bool = false
    weak var dismissDelegate: PopupViewDismissDelegate?
    var outsideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        guard shouldDismissViewOnTapOutside else {return}
        addTapToDismissGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard shouldAddFullOverlay else {return}
        UIView.animate(withDuration: 0.1) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard shouldAddFullOverlay else {return}
        self.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismissDelegate?.didDismissPopupView()
    }

    private func addTapToDismissGesture() {
        outsideButton = UIButton(frame: self.view.bounds)
        self.view.addSubview(outsideButton)
        outsideButton.translatesAutoresizingMaskIntoConstraints = false
        outsideButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        outsideButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        outsideButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        outsideButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        outsideButton.setTitle("", for: .normal)
        outsideButton.backgroundColor = .clear
        self.view.sendSubviewToBack(outsideButton)
        outsideButton.addTarget(self, action: #selector(dismissViewController(_:)), for: .touchUpInside)
    }
    
    @objc private func dismissViewController(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
    }
}
