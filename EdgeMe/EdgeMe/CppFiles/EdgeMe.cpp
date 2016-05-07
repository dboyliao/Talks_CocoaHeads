//
//  EdgeMe.cpp
//  EdgeMe
//
//  Created by DboyLiao on 5/7/16.
//  Copyright © 2016 spe3d. All rights reserved.
//

#include "EdgeMe.hpp"

using namespace cv;
using namespace std;

EdgeMe::EdgeMe(float alpha){
    this->alpha = alpha;
}

Mat EdgeMe::apply(Mat &image){
    
    if (image.channels() == 1){
        cvtColor(image, image, COLOR_GRAY2BGR);
    }
    
    Mat result = Mat(image.rows, image.cols, CV_8UC3, Scalar(0, 0, 0));
    Mat_<uchar> mask;
    Canny(image, mask, 60, 80);
    
    mask = 255 - mask;
    image.copyTo(result, mask);
    
    return result;
}