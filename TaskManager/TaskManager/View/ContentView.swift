//
//  ContentView.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/6/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Darwin
import Foundation
import AppKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Parse.getOutput()
        return VStack {
            HStack {
                Section(header: Text("PID's")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
                Section(header: Text("dfsdf")) {
                    Spacer()
                }
            }
            List {
                Text("dsfsdf")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
