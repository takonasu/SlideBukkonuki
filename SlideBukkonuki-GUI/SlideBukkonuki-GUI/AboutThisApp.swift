//
//  AboutThisApp.swift
//  SlideBukkonuki-GUI
//
//  Created by takumi saito on 2020/05/08.
//  Copyright © 2020 takpika. All rights reserved.
//

import SwiftUI

struct AboutThisApp: View {
    var body: some View {
        VStack(){
            Text("Hello")
            Button("Close"){
                NSApplication.shared.keyWindow?.close()
            }
        }
    }
}

struct AboutThisApp_Previews: PreviewProvider {
    static var previews: some View {
        AboutThisApp()
    }
}
