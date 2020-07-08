//
//  AppDelegate.swift
//  ImageMask
//
//  Created by Виталий Баник on 02.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let contentView = ProcessImageView(viewModel: ProcessImageViewModel(configType: .processMaskFileLocalPNG))

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 430, height: 300),
            styleMask: [.titled, .closable],
            backing: .buffered, defer: false)
        
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

}
