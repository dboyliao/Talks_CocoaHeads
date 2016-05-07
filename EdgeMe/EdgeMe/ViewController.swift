//
//  ViewController.swift
//  EdgeMe
//
//  Created by DboyLiao on 5/7/16.
//  Copyright © 2016 spe3d. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var edgeMeButton:UIButton!
    @IBOutlet weak var cameraButton:UIButton!
    @IBOutlet weak var pickButton:UIButton!
    @IBOutlet weak var imageView:UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if imageView.image == nil {
            self.edgeMeButton.enabled = false
        }
        
    }


}

