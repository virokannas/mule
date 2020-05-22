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

class NodeGizmo {
    var node : SCNNode?
    var controls : SCNNode? = nil
    static var mode : EditMode = .move
    
    init(_ node : SCNNode) {
        self.node = node
        self.createControls()
    }
    
    func destroyControls() {
        if (self.controls != nil) {
            self.controls!.removeFromParentNode()
        }
    }
    
    func createControls() {
        self.destroyControls()
        self.controls = SCNNode()
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
            let val = self.value(forKey: "hasGizmo")
            if (val != nil) {
                return val as! Bool
            }
            return false
        }
        set(controls) {
            let val = self.value(forKey: "hasGizmo")
            var has = false
            if (val != nil) {
                has = val as! Bool
            }
            
            if (has && !controls) {
                let gizmo = self.value(forKey: "gizmo")
                if(gizmo != nil) {
                    (gizmo as! NodeGizmo).destroyControls()
                    self.setValue(nil, forKey: "gizmo")
                }
            } else if (!has && controls) {
                var _gizmo = NodeGizmo(self)
                //self.setValue(_gizmo, forKey: "gizmo")
            }
            self.setValue(controls, forKey: "hasGizmo")
        }
    }
}
