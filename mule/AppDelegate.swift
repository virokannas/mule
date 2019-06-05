//
//  AppDelegate.swift
//  mule
//
//  Created by Simo Virokannas on 1/5/19.
//  Copyright © 2019 IHIHI. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var editor: EditorController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        printUSDVersion()
    }
    
    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        editor.loadUSDFromURL(URL(fileURLWithPath: filenames.first!))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

}

