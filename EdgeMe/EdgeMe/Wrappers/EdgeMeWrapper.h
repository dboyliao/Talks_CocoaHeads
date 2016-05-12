//
//  EdgeMeWrapper.h
//  EdgeMe
//
//  Created by DboyLiao on 5/7/16.
//  Copyright © 2016 spe3d. All rights reserved.
//

#ifndef EdgeMeWrapper_h
#define EdgeMeWrapper_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EdgeMeWrapper : NSObject

-(instancetype) initWithCannyMin:(double)min cannyMax:(double)max;
-(UIImage *)getProcessedImage:(UIImage *)fromImage;

@end

#endif /* EdgeMeWrapper_h */
