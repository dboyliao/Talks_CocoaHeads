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
    grayScale.create(image.rows, image.cols);
    
    cvtColor(image, grayScale, COLOR_BGR2GRAY);
    
    return grayScale;
}