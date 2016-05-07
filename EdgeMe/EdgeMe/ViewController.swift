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
        self.edgemeWrapper = EdgeMeWrapper(alph: 0.3)
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
        
        let space = CGImageGetColorSpace(image.CGImage)
        print(space)
        
        self.imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func processImage(){
        
        guard let image = self.imageView.image else {
            return
        }
        
        let edgedImage = self.edgemeWrapper!.getProcessedImage(image)
        let context = CIContext(options: nil)
        let ciImage = CIImage(CGImage: edgedImage.CGImage!)
        let filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: kCIInputIntensityKey)
        let outCIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
        let finalCGImage = context.createCGImage(outCIImage, fromRect: outCIImage.extent)
        
        self.imageView.image = UIImage(CGImage: finalCGImage)
    }


}

