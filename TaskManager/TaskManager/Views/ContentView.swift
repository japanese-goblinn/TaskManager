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
                VStack(alignment: .leading) {
                    Text("Info")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Divider()
                    VStack(alignment: .leading) {
                        Text("CPU")
                            .font(.headline)
                            .bold()
                            .padding(.top)
                            .padding(.leading)
                        Divider()
                        HStack(alignment: .center) {
                            Text(viewModel.percentageUsage(for: .system))
                                .bold()
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(24)
                            Text(viewModel.percentageUsage(for: .user))
                                .bold()
                                .padding()
                                .background(Color.red)
                                .cornerRadius(24)
                            Text(viewModel.percentageUsage(for: .idle))
                                .bold()
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(24)
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color(red: 47/255, green: 48/255, blue: 50/255))
                    .cornerRadius(20)
                    .padding(.top)
                }
                .padding()
                HStack {
                    VStack(alignment: .leading) {
                        Text("CPU Usage")
                            .font(.title)
                            .fontWeight(.bold)
                        Divider()
                        Spacer()
                        CPUChartViewControllerWrapper(viewModel: viewModel)
                    }
                    VStack(alignment: .leading) {
                        Text("Memory Usage")
                            .font(.title)
                            .fontWeight(.bold)
                        Divider()
                        Spacer()
                        MemoryChartViewControllerWrapper()
                    }
                }
                .padding()
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
        .padding()
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
            Service.systemInfoOutput(sleep: 2) { sysInfo in
                DispatchQueue.main.async { [weak self] in
                    self?.sysInfo = sysInfo
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
