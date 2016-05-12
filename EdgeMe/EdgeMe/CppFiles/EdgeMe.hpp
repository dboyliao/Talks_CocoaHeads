//
//  EdgeMe.hpp
//  EdgeMe
//
//  Created by DboyLiao on 5/7/16.
//  Copyright © 2016 spe3d. All rights reserved.
//

#ifndef EdgeMe_hpp
#define EdgeMe_hpp

#include <stdio.h>
#include "opencv2/opencv.hpp"

using namespace cv;

class EdgeMe {
private:
    double cannyMin, cannyMax;

public:
    EdgeMe(double cannyMin, double cannyMax);
    Mat apply(Mat &image);
};

#endif /* EdgeMe_hpp */
