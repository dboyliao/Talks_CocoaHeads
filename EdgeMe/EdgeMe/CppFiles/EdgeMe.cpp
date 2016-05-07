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
    
    Mat_<uchar> grayScale;
    if (image.channels() != 1){
        cvtColor(image, grayScale, COLOR_BGR2GRAY);
    } else {
        grayScale = Mat_<uchar>(image);
    }
    
    Mat result = Mat(image.rows, image.cols, CV_8UC3, Scalar(0, 0, 0));
    Mat_<uchar> mask;
    Canny(grayScale, mask, 60, 80);
    
    mask = 255 - mask;
    image.copyTo(result, mask);
    
    return result;
}