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

#ifndef BRIDGING_HEADER
extern "C" {
#endif
    void printUSDVersion();
    bool loadUSD(const char *path);
    bool saveStageToFile(const char *path);
    bool saveOverridesToFile(const char *path);
    bool changeBoolParam(const char *path, const char *param, bool value);
    bool changeStringParam(const char *path, const char *param, const char *value);
#ifndef BRIDGING_HEADER
};
#endif

#endif /* Synchronizer_hpp */
