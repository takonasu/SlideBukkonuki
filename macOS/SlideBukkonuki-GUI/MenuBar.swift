//
//  MenuBar.swift
//  SlideBukkonuki-GUI
//
//  Created by takumi saito on 2020/05/08.
//  Copyright © 2020 takpika. All rights reserved.
//

import Cocoa
import SwiftUI

class MenuBar: NSObject {

    @IBAction func AboutThisAppBT(_ sender: Any) {
        
    }
    @IBAction func HelpBT(_ sender: Any) {
        let url = "https://github.com/takonasu/SlideBukkonuki/blob/master/README.md"
        let task = Process()
        task.launchPath = "/usr/bin/env";
        task.arguments = ["open","-a","safari",url]
        task.launch()
    }
}


