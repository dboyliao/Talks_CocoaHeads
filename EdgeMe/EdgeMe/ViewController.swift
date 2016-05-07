//
//  ViewController.swift
//  EdgeMe
//
//  Created by DboyLiao on 5/7/16.
//  Copyright © 2016 spe3d. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var edgemeWrapper:EdgeMeWrapper?
    @IBOutlet weak var edgeMeButton:UIButton!
    @IBOutlet weak var cameraButton:UIButton!
    @IBOutlet weak var pickButton:UIButton!
    @IBOutlet weak var imageView:UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.edgemeWrapper == nil {
            self.edgemeWrapper = EdgeMeWrapper(alph: 0.3)
        }
        
        if imageView.image == nil {
            self.edgeMeButton.enabled = false
        } else {
            self.edgeMeButton.enabled = true
        }
        
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.cameraButton.enabled = false
        }
        
    }
    
    @IBAction func pressButton(sender: UIButton){
        
        switch sender {
        case self.edgeMeButton:
            self.processImage()
        
        case self.cameraButton:
            let nextVC = UIImagePickerController()
            nextVC.sourceType = .Camera
            nextVC.cameraDevice = .Rear
            nextVC.delegate = self
            self.presentViewController(nextVC, animated: true, completion: nil)
        
        case self.pickButton:
            let nextVC = UIImagePickerController()
            nextVC.sourceType = .PhotoLibrary
            nextVC.delegate = self
            self.presentViewController(nextVC, animated: true, completion: nil)
        
        default:
            print("nothing!")
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func processImage(){
        
        guard let image = self.imageView.image else {
            return
        }
        
        let newImage = self.edgemeWrapper!.getProcessedImage(image)
        self.imageView.image = newImage
    }


}

