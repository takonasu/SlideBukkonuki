//
//  ATA.swift
//  SlideBukkonuki-GUI
//
//  Created by takumi saito on 2020/05/08.
//  Copyright © 2020 takpika. All rights reserved.
//

import Cocoa

class ATA: NSViewController {
    @IBOutlet weak var imageview: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.contentMaxSize = view.frame.size
        self.view.window?.contentMinSize = view.frame.size
        imageview.image = NSImage(named: "AppIcon")
        // Do view setup here.
    }
    
    func openURL(url: String){
        let task = Process()
        task.launchPath = "/usr/bin/env";
        task.arguments = ["open","-a","safari",url]
        task.launch()
    }
    @IBAction func TWtakpikaBT(_ sender: Any) {
        openURL(url: "https://twitter.com/takpika0308")
    }
    @IBAction func GHtakpikaBT(_ sender: Any) {
        openURL(url:"https://github.com/takpika")
    }
    @IBAction func TWSGOBT(_ sender: Any) {
        openURL(url: "https://twitter.com/sgo_ITF")
    }
    @IBAction func TWtakonasuBT(_ sender: Any) {
        openURL(url: "https://twitter.com/ITF_tako")
    }
    
    @IBAction func WBtakonasuBT(_ sender: Any) {
        openURL(url:"https://takonasu.net")
    }
    @IBAction func GHtakonasuBT(_ sender: Any) {
        openURL(url:"https://github.com/takonasu")
    }
}
