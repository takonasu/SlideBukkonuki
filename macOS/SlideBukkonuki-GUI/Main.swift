//
//  Main.swift
//  SlideBukkonuki-GUI
//
//  Created by takumi saito on 2020/05/07.
//  Copyright © 2020 takpika. All rights reserved.
//

import Foundation
import SwiftUI

func openFile() -> URL{
    var str = URL(fileURLWithPath: "")
    let openPanel = NSOpenPanel()
    openPanel.allowsMultipleSelection = false
    openPanel.canChooseDirectories = false
    openPanel.canCreateDirectories = false
    openPanel.canChooseFiles = true
    openPanel.allowedFileTypes = ["mp4"]
    if openPanel.runModal().rawValue == NSApplication.ModalResponse.OK.rawValue{
        if let fileURL = openPanel.url {
            str = fileURL
        }
    }
    return str
}

func bukkonuku(isAlertOn: Bool, i: String, t: Int, r:Int, a:Int, f:Int){
    let openPanel = NSOpenPanel()
    openPanel.allowsMultipleSelection = false
    openPanel.canChooseDirectories = true
    openPanel.canCreateDirectories = true
    openPanel.canChooseFiles = false
    if openPanel.runModal().rawValue == NSApplication.ModalResponse.OK.rawValue{
        if openPanel.url != nil{
            let o = openPanel.url!.path + "/"
            bukkonuku_cmd(isAlertOn: isAlertOn, i: i, o: o, t: t, r: r, a: a, f: f)
        }
    }
}

func bukkonuku_cmd(isAlertOn: Bool, i: String, o: String, t: Int, r:Int, a:Int, f:Int){
    let bundle = Bundle.main
    let path = (bundle.path(forResource: "SlideBukkonuki", ofType: ""))!
    /*let setup_path = (bundle.path(forResource: "setup", ofType: "sh"))!
    let url = URL(fileURLWithPath: setup_path)
    let url2 = url.deletingLastPathComponent()
    var url3 = ""
    do{
        url3 = try String(contentsOf: url2)
    }catch{
        url3 = ""
    }
    print(path)
    let temp_dir = FileManager.default.temporaryDirectory.path
    print(url3)
 */
    let task = Process()
    task.launchPath = "/usr/bin/env";
    //task.arguments = ["sh",setup_path,temp_dir,url3,path,i,o,String(t),String(r),String(a),String(f)]
    task.arguments = [path,"-i",i,"-o",o,"-t",String(t),"-r",String(r),"-a",String(a),"-f",String(f)]
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    let output = pipe.fileHandleForReading.readDataToEndOfFile()
    let outputStr:NSString = NSString(data:output,encoding: String.Encoding.utf8.rawValue)!
    print(outputStr)
}
enum Translation{
    static var Settings: LocalizedStringKey{
        return "ST"
    }
}
