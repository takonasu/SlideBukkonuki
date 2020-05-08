//
//  ContentView.swift
//  SlideBukkonuki-GUI
//
//  Created by takumi saito on 2020/05/07.
//  Copyright © 2020 takpika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var iki_chi = 10
    @State var aspect = 0
    @State var kankaku = 5
    @State var file_path = ""
    @State var file_name = "動画を選択してください。"
    @State var trimming = 0
    @State var isAlertOn = false
    let bundle = Bundle.main
    var body: some View {
        VStack(){
            HStack(){
                Button("動画選択"){
                    let url = openFile()
                    if url != URL(fileURLWithPath: ""){
                        self.file_path = url.path
                        self.file_name = (url.path as NSString).lastPathComponent
                    }
                }
                .padding(.trailing)
                Text(file_name)
                Spacer()
                if self.file_path != ""{
                    Button("ぶっこ抜く！"){
                        bukkonuku(isAlertOn: self.isAlertOn, i: self.file_path, t: self.iki_chi, r: self.trimming, a: self.aspect, f: self.kankaku)
                    }
                }
            }
            Divider()
            HStack(){
                Text("設定")
                .font(.body)
                Spacer()
            }
            VStack(){
                HStack(){
                    Stepper(value: $iki_chi, in: 0...100) {
                        Text("閾値: \(iki_chi)")
                    }
                    Spacer()
                }
                HStack(){
                    Picker(selection: $aspect, label:
                    Text("スライドのアスペクト比")
                    ) {
                        Text("4:3（正方形に近い）").frame(width: 120.0).tag(0)
                        Text("16:9（横長）").tag(1)
                    }.pickerStyle(RadioGroupPickerStyle())
                    Spacer()
                }
                HStack(){
                    Stepper(value: $kankaku, in: 0...100) {
                        Text("フレーム取得間隔: \(kankaku)")
                    }
                    Spacer()
                }
                HStack(){
                    Stepper(value: $trimming, in: 0...7680) {
                        Text("トリミング開始位置: \(trimming)")
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(.all)
        .frame(width: 480.0, height: 250.0)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
