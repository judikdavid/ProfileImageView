//
//  ViewController.swift
//  ProfileImageView
//
//  Created by David Judik on 02/16/2016.
//  Copyright (c) 2016 David Judik. All rights reserved.
//

import UIKit
import ProfileImageView

class ViewController: UIViewController {
    
    let profileImageView1 = ProfileImageView(frame: CGRectMake(20, 20, 120, 120))
    let profileImageView2 = ProfileImageView(frame: CGRectMake(20, 160, 120, 120))
    let profileImageView3 = ProfileImageView(frame: CGRectMake(20, 300, 120, 120))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profileImageView1.lastName = "Judik"
        profileImageView1.firstName = "David"
        
        view.addSubview(profileImageView1)

        profileImageView2.image = UIImage(named: "dad")
        view.addSubview(profileImageView2)

        profileImageView3.image = UIImage(named: "girl")
        profileImageView3.hasOverlay = true
        view.addSubview(profileImageView3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

