//
//  EdgeMeWrapper.mm
//  EdgeMe
//
//  Created by DboyLiao on 5/7/16.
//  Copyright © 2016 spe3d. All rights reserved.
//


#import "EdgeMeWrapper.h"
#include "EdgeMe.hpp"
#include "opencv2/opencv.hpp"
#include "opencv2/imgcodecs/ios.h"

@interface EdgeMeWrapper ()

@property EdgeMe* edgeMe;

@end

@implementation EdgeMeWrapper

-(instancetype) initWithCannyMin:(double)min cannyMax:(double)max {
    self = [super init];
    
    if (self) {
        self.edgeMe = new EdgeMe(min, max);
    }
    
    return self;
}

-(UIImage *) getProcessedImage:(UIImage *)fromImage {
    
    Mat cvImage;
    UIImageToMat(fromImage, cvImage);
    Mat result = self.edgeMe->apply(cvImage);
    
    return MatToUIImage(result);
}

@end