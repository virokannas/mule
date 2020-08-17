//
//  NodeGizmo.swift
//  mule
//
//  Created by Simo Virokannas on 6/4/19.
//  Copyright © 2019 IHIHI. All rights reserved.
//

import Foundation
import SceneKit

enum EditMode {
    case move
    case rotate
    case scale
}

extension SCNVector3 {
    var inverse : SCNVector3 {
        return SCNVector3(1.0 / self.x, 1.0 / self.y, 1.0 / self.z)
    }
}

class NodeGizmo : SCNNode {
    var controls : SCNNode? = nil
    static var mode : EditMode = .move
    
    func destroyControls() {
        self.removeFromParentNode()
    }
    
    func createControls(_ node: SCNNode) {
        self.name = "_gizmo"
        self.destroyControls()
        self.controls = SCNNode()
        self.controls!.scale = node.scale.inverse
        self.addChildNode(self.controls!)
        node.addChildNode(self)
        if(NodeGizmo.mode == .move) {
            let x = SCNNode(geometry: SCNBox(width: 1.0, height: 0.1, length: 0.1, chamferRadius: 0.0))
            let y = SCNNode(geometry: SCNBox(width: 0.1, height: 1.0, length: 0.1, chamferRadius: 0.0))
            let z = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 1.0, chamferRadius: 0.0))
            self.controls!.addChildNode(x)
            self.controls!.addChildNode(y)
            self.controls!.addChildNode(z)
        }
    }
}

extension SCNNode {
    var hasControls : Bool {
        get {
            let val = self.childNode(withName: "_gizmo", recursively: false)
            return (val != nil)
        }
        set(controls) {
            let val = self.childNode(withName: "_gizmo", recursively: false)
            
            if (val != nil && !controls) {
                (val as! NodeGizmo).destroyControls()
            } else if (val == nil && controls) {
                let gizmo = NodeGizmo()
                gizmo.createControls(self)
            }
        }
    }
}
