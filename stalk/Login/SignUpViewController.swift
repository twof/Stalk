//
//  LoginViewController.swift
//  stalk
//
//  Created by Clara Hwang on 7/24/16.
//  Copyright © 2016 carl. All rights reserved.
//

import UIKit
class SignUpViewController: UIViewController {

	@IBAction func onLoginButtonTap(sender: AnyObject) {
		if firstNameTextField.text != ""
		{
			if lastNameTextField.text != ""
			{
				let first = firstNameTextField.text!
				let last = lastNameTextField.text!
				PeerHelper.ownAccount.name = first + " " + last
//				self.showViewController(vc , sender: self)
				self.performSegueWithIdentifier("Login", sender: self)
				return
			}
		}
		
		let alertController = UIAlertController(title: nil, message: "You must fill in the name fields", preferredStyle: .Alert)
		
		let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
		alertController.addAction(okAction)
		
		self.presentViewController(alertController, animated: true, completion: nil)
		
	}
	
	@IBOutlet weak var firstNameTextField: UITextField!
	
	@IBOutlet weak var lastNameTextField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}
