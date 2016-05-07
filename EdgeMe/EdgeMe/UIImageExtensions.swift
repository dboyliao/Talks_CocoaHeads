//
//  UIImageExtensions.swift
//  EdgeMe
//
//  Created by DboyLiao on 5/9/16.
//  Copyright © 2016 spe3d. All rights reserved.
//

import UIKit

extension UIImage {
    
    var orientationUp:UIImage? {
        
        if self.imageOrientation == UIImageOrientation.Up {
            if let cgImage = self.CGImage {
                return UIImage(CGImage: cgImage)
            } else {
                return nil
            }
        }
        
        var transform = CGAffineTransformIdentity
        
        /*
         For each case, we apply following operation on image:
         
         1. Rotate the image to make the orientaion align with .Up.
         2. Flip the x-axis if the image is mirrored.
         */
        switch self.imageOrientation {
        case .Down:
            // make rotation
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
        case .DownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            // flip the x-axis.
            transform = CGAffineTransformScale(transform, -1, 1)
        case .Left:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        case .LeftMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            transform = CGAffineTransformScale(transform, -1, 1)
        case .Right:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        case .RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
            transform = CGAffineTransformScale(transform, -1, 1)
        case .UpMirrored:
            transform = CGAffineTransformScale(transform, -1, 1)
        case .Up:
            print("how could you get here?")
        }
        
        
        let context = CGBitmapContextCreate(nil,
                                            Int(self.size.width),
                                            Int(self.size.height),
                                            CGImageGetBitsPerComponent(self.CGImage),
                                            0,
                                            CGImageGetColorSpace(self.CGImage),
                                            CGImageGetBitmapInfo(self.CGImage).rawValue)
        
        CGContextConcatCTM(context, transform)
        
        var finalImage:UIImage? = nil
        switch self.imageOrientation {
        case .Up, .UpMirrored, .Down, .DownMirrored:
            CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage)
        case .Left, .LeftMirrored, .Right, .RightMirrored:
            CGContextDrawImage(context, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage)
        }
        
        if let cgImage = CGBitmapContextCreateImage(context) {
            finalImage = UIImage(CGImage:cgImage)
        }
        
        return finalImage
    }
}