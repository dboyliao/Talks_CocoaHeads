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

    override func viewDidLoad() {
        self.edgemeWrapper = EdgeMeWrapper(cannyMin: 60, cannyMax: 80)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if imageView.image == nil {
            self.edgeMeButton.enabled = false
        } else {
            self.edgeMeButton.enabled = true
        }
        
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.cameraButton.enabled = false
        }
        
    }
    
    @IBAction func pressButton(sender: UIButton) {
        switch sender {
        case self.edgeMeButton:
            
            if let image = self.imageView.image?.orientationUp {
                let edgedImage = self.edgemeWrapper!.getProcessedImage(image)
                let context = CIContext(options: nil)
                let ciImage = CIImage(CGImage: edgedImage.CGImage!)
                let filter = CIFilter(name: "CISepiaTone")!
                filter.setValue(ciImage, forKey: kCIInputImageKey)
                filter.setValue(0.8, forKey: kCIInputIntensityKey)
                let outCIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
                let finalCGImage = context.createCGImage(outCIImage, fromRect: outCIImage.extent)
                
                self.imageView.image = UIImage(CGImage: finalCGImage)
            } else {
                print("process fail.")
            }
            
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}

