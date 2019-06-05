//
//  Editor.swift
//  mule
//
//  Created by Simo Virokannas on 1/5/19.
//  Copyright © 2019 IHIHI. All rights reserved.
//

import Foundation
import Cocoa
import SceneKit
import SceneKit.ModelIO

func degreesToRadians(_ degrees: Float) -> Float {
    return degrees * .pi / 180
}

func toQuaternion( _ roll : Float, _ pitch: Float, _ yaw : Float) -> SCNQuaternion
{
    let cy = cos(yaw * 0.5);
    let sy = sin(yaw * 0.5);
    let cp = cos(pitch * 0.5);
    let sp = sin(pitch * 0.5);
    let cr = cos(roll * 0.5);
    let sr = sin(roll * 0.5);
    
    return SCNQuaternion(
        x: CGFloat(cy * cp * sr - sy * sp * cr),
        y: CGFloat(sy * cp * sr + cy * sp * cr),
        z: CGFloat(sy * cp * cr - cy * sp * sr),
        w: CGFloat(cy * cp * cr + sy * sp * sr)
        )
}

func fullNodePath(node: SCNNode) -> String {
    var ret = ""
    if (node.name != nil) {
        ret = node.name!
    }
    if(node.parent != nil) {
        return fullNodePath(node: node.parent!) + "/" + ret
    }
    return ret
}

class EditorController : NSViewController, NSOutlineViewDataSource {
    @IBOutlet var sceneview : SCNView!
    @IBOutlet var outline : NSOutlineView!
    var mdl : MDLAsset?
    
    override func awakeFromNib() {
        sceneview.showsStatistics = true
        sceneview.scene = SCNScene()
        
        if(CommandLine.arguments.count > 1) {
            let filepath = CommandLine.arguments[1]
            let url = URL(fileURLWithPath: filepath)
            loadUSDFromURL(url)
        }
    }
    
    func setSubdivision(_ obj: SCNNode, _ level: Int) {
        if obj.geometry != nil {
            obj.geometry!.subdivisionLevel = level
            obj.geometry!.wantsAdaptiveSubdivision = false
        }
        for subobj in obj.childNodes {
            setSubdivision(subobj, level)
        }
    }
    
    func loadUSDFromURL(_ url: URL ) {
        do {
            
            let scene = try SCNScene(url:url)
            for obj in scene.rootNode.childNodes {
                setSubdivision(obj, 0)
            }
            loadUSD(url.path)
            
            sceneview.scene = scene
            
            let cameras = (scene.rootNode.childNodes(passingTest: { (node, value) -> Bool in
                if node.camera != nil {
                    return true
                }
                return false
            }))
            // load the scene in c++
            outline.reloadData()
        } catch {
            
        }
    }
    
    @IBAction func openFile ( sender: Any ) {
        let dlg = NSOpenPanel()
        dlg.allowsMultipleSelection = false
        dlg.allowedFileTypes = ["usd","usda","usdz"]
        dlg.canChooseDirectories = false
        dlg.runModal()
        if let chosenfile = dlg.url {
            loadUSDFromURL(chosenfile)
            NSDocumentController.shared.noteNewRecentDocumentURL(chosenfile)
        }
    }
    
    @IBAction func saveStage ( sender: Any ) {
        let dlg = NSSavePanel()
        dlg.allowedFileTypes = ["usd","usda"]
        dlg.runModal()
        if let chosenfile = dlg.url {
            saveStageToFile(chosenfile.path)
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        let node = (item as! SCNNode)
        if tableColumn!.identifier.rawValue == "path" {
            if node.name != nil {
                return node.name!
            } else {
                return "root"
            }
        } else if tableColumn!.identifier.rawValue == "vis" {
            return !node.isHidden
        }
        return nil
    }
    
    func outlineView(_ outlineView: NSOutlineView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, byItem item: Any?) {
        var node = (item as! SCNNode)
        let full_path = fullNodePath(node: node)
        if tableColumn!.identifier.rawValue == "vis" {
            node.isHidden = !(object as! Bool)
            changeBoolParam(full_path, "hidden", false)
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return sceneview.scene!.rootNode
        }
        return (item as! SCNNode).childNodes[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return Bool((item as! SCNNode).childNodes.count > 0)
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            // root
            return 1
        } else {
            return (item as! SCNNode).childNodes.count
        }
    }
    
}
