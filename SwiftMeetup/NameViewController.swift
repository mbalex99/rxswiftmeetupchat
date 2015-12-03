//
//  NameViewController.swift
//  SwiftMeetup
//
//  Created by Maximilian Alexander on 12/3/15.
//  Copyright © 2015 Epoque. All rights reserved.
//

import UIKit
import Cartography

class NameViewController: UIViewController {

    let nameTextField = UITextField()
    let acceptButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(nameTextField)
        self.view.addSubview(acceptButton)
                acceptButton.addTarget(self, action: "acceptButtonTapped:", forControlEvents: .TouchUpInside)
        self.styleSetup()
    }
    
    func acceptButtonTapped(sender: AnyObject){
        let name : String = nameTextField.text == nil ? "Anonymous" : nameTextField.text!
        self.navigationController?.pushViewController(ChatViewController(name: name), animated: true)
    }
    
    func styleSetup(){
        self.view.backgroundColor = UIColor.whiteColor()
        nameTextField.backgroundColor = UIColor.whiteColor()
        nameTextField.borderStyle = .Bezel
        nameTextField.placeholder = "What is your name?"
        acceptButton.setTitle("Let's go", forState: .Normal)
        acceptButton.backgroundColor = UIColor.blueColor()
        acceptButton.layer.cornerRadius = 8
        acceptButton.layer.masksToBounds = true

        
        constrain(nameTextField, acceptButton) { (nameTextField, acceptButton) -> () in
            nameTextField.centerY == nameTextField.superview!.centerY
            nameTextField.left == nameTextField.superview!.left + 15
            nameTextField.right == nameTextField.superview!.right - 15
            nameTextField.height == 60
            
            
            acceptButton.top == nameTextField.bottom + 20
            acceptButton.width == nameTextField.width
            acceptButton.height == 60
            acceptButton.centerX == nameTextField.centerX
            
        }
    }


}
