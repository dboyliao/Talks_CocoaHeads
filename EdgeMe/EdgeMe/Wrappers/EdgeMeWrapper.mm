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
#include "opencv2/highgui/ios.h"

@interface EdgeMeWrapper ()

@property EdgeMe* edgeMe;

@end

@implementation EdgeMeWrapper

-(instancetype) initWithAlph:(float)alpha {
    self = [super init];
    
    if (self) {
        self.edgeMe = new EdgeMe(alpha);
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