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
                Text("CPU usage")
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                Divider()
                Text(viewModel.percentageUsage(for: .system))
                    .bold()
                Text(viewModel.percentageUsage(for: .user))
                    .bold()
                Text(viewModel.percentageUsage(for: .idle))
                    .bold()
                Spacer()
                LineChartViewControllerWrapper(viewModel: viewModel)
            }
            .tabItem {
                Text("System Info")
            }
            .background(Color.white)
            .tag(0)
            
            VStack {
                ProcessesViewControllerWrapper()
            }
            .tabItem {
                Text("Processes")
            }
            .tag(1)
        }
        .padding()
        .background(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.viewModel.observingSystemInfo()
        }
    }
    
}

class ViewModel: ObservableObject {
      
    @Published private(set) var sysInfo: SystemInfo? = nil
    
    enum Info {
        case system
        case user
        case idle
    }
      
    func percentageUsage(for type: Info) -> String {
        switch type {
        case .system:
            return String(
                format: "System: %.2f",
                sysInfo?.systemPercentageUsage ?? 0
            ) + "%"
        case .user:
            return String(
                format: "User: %.2f",
                sysInfo?.userPercentageUsage ?? 0
            ) + "%"
        case .idle:
            return String(
                format: "Idle: %.2f",
                sysInfo?.idlePercentageUsage ?? 0
            ) + "%"
        }
    }

    func observingSystemInfo() {
        DispatchQueue.global().async {
            Parse.getSystemInfoOutput(sleep: 2) { sysInfo in
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
