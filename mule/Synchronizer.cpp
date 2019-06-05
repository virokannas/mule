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
    if(stage != NULL) {
        g_stage = stage;
        pxr::SdfLayerRefPtr layer = pxr::SdfLayer::Find(path);
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

bool saveStageToFile(const char *path) {
    g_stage->Flatten()->Export(path);
    return true;
}

bool saveOverridesToFile(const char *path) {
    g_stage->GetRootLayer()->Export(path);
    return true;
}

bool changeBoolParam(const char *path, const char *param, bool value) {
    pxr::SdfPath sdf_path(path);
    pxr::UsdPrim prim = g_stage->GetPrimAtPath(sdf_path);
    if(strcmp(param, "hidden") == 0) {
        prim.SetHidden(value);
    }
    return false;
}

bool changeStringParam(const char *path, const char *param, const char *value) {
    return false;
}
