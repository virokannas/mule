//
//  Synchronizer.cpp
//  mule
//
//  Created by Simo Virokannas on 1/6/19.
//  Copyright © 2019 IHIHI. All rights reserved.
//

#include "Synchronizer.hpp"
#include <pxr/pxr.h>

void printUSDVersion() {
    printf("USD Library version %d.%d.%d\n", PXR_MAJOR_VERSION, PXR_MINOR_VERSION, PXR_PATCH_VERSION);
}
