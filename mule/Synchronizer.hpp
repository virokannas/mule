//
//  Synchronizer.hpp
//  mule
//
//  Created by Simo Virokannas on 1/6/19.
//  Copyright © 2019 IHIHI. All rights reserved.
//

#ifndef Synchronizer_hpp
#define Synchronizer_hpp

#include <stdio.h>

extern "C" {
    void printUSDVersion();
    bool loadUSD(const char *path);
};

#endif /* Synchronizer_hpp */
