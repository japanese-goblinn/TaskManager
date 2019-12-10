//
//  ContentView.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/6/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import SwiftUI
import Charts
import Cocoa

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        TabView {
            VStack {
                Text(
                    String(
                        format: "System: %.2f",
                        viewModel.sysInfo?.systemPercentageUsage ?? 0
                    ) + "%"
                )
                .bold()
                Text(
                    String(
                        format: "User: %.2f",
                        viewModel.sysInfo?.userPercentageUsage ?? 0
                    ) + "%"
                )
                .bold()
                Text(
                    String(
                        format: "Idle: %.2f",
                        viewModel.sysInfo?.idlePercentageUsage ?? 0
                    ) + "%"
                )
                .bold()
                Spacer()
                LineChartViewControllerWrapper(viewModel: viewModel)
            }
            .tabItem {
                Text("System Info")
            }
            .tag(0)
            
            VStack {
                ProcessesViewControllerWrapper()
            }
            .tabItem {
                  Text("Processes")
            }
            .tag(1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.viewModel.observingSystemInfo()
        }
    }
}

class ViewModel: ObservableObject {
      
      @Published private(set) var sysInfo: SystemInfo? = nil
      
      func observingSystemInfo() {
        DispatchQueue.global().async {
            Parse.getSystemInfoOutput { sysInfo in
                DispatchQueue.main.async {
                    self.sysInfo = sysInfo
                }
            }
        }
      }
  }


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
