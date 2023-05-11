//
//  Utils.swift
//  Captuocr
//
//  Created by Gragrance on 2017/12/1.
//  Copyright © 2017年 Gragrance. All rights reserved.
//

import Foundation

import Cocoa


class Utils {
    static func hasScreenCapturePermission() -> Bool {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        return AXIsProcessTrustedWithOptions(options as CFDictionary)
    }
    
    static func capturePic() -> String? {
        //        if !hasScreenCapturePermission() {
        //            let alert = NSAlert()
        //            alert.messageText = "Screenshot permission needed"
        //            alert.informativeText = "This app needs permission to take screenshots. Please grant the permission in the System Preferences."
        //            alert.addButton(withTitle: "Open System Preferences")
        //            alert.addButton(withTitle: "Cancel")
        //
        //            let response = alert.runModal()
        //            if response == NSApplication.ModalResponse.alertFirstButtonReturn {
        //                if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture") {
        //                    NSWorkspace.shared.open(url)
        //                }
        //            }
        //            return nil
        //        } else {
        // 权限已授权，可以开始录屏
        let destinationPath = NSTemporaryDirectory() + UUID().uuidString + ".png"
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        task.arguments = ["-i", "-r", destinationPath]
        task.launch()
        task.waitUntilExit()
        var notDir = ObjCBool(false)
        return FileManager.default.fileExists(atPath: destinationPath, isDirectory: &notDir)
        ? destinationPath
        : nil
        
        //        }
        
    }
}
