//
//  ViewController.swift
//  stalk
//
//  Created by JAEHYUN SIM on 7/23/16.
//  Copyright © 2016 carl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PPKControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		PPKController.enableWithConfiguration(APP_KEY, observer:self)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}