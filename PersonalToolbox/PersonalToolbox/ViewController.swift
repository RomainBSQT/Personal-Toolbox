//
//  ViewController.swift
//  PersonalToolbox
//
//  Created by Romain Bousquet on 04/11/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var image = UIImageView(frame: CGRectMake(50, 50, 200, 200))
        self.view.addSubview(image)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

