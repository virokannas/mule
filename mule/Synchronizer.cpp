//
//  Synchronizer.cpp
//  mule
//
//  Created by Simo Virokannas on 1/6/19.
//  Copyright © 2019 IHIHI. All rights reserved.
//

#include "Synchronizer.hpp"
#include <pxr/pxr.h>
#include <pxr/usd/sdf/layer.h>
#include <pxr/usd/usd/stage.h>

void printUSDVersion() {
    printf("USD Library version %d.%d.%d\n", PXR_MAJOR_VERSION, PXR_MINOR_VERSION, PXR_PATCH_VERSION);
}

pxr::UsdStageRefPtr g_stage;
pxr::SdfLayerRefPtr g_current_layer;

bool loadUSD(const char *path) {
    pxr::UsdStageRefPtr stage = pxr::UsdStage::Open(path);
    pxr::SdfLayerRefPtr layer = pxr::SdfLayer::Find(path);
    if(stage != NULL) {
        g_stage = stage;
        if(layer != NULL) {
            g_current_layer = layer;
        } else {
            g_current_layer = NULL;
        }
        printf("Loaded USD scene at %s\n",path);
    } else {
        printf("Failed to load USD scene at %s\n",path);
        g_stage = NULL;
    }
    return g_stage != NULL;
}

