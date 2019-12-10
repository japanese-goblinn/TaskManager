//
//  LineChartViewControllerWrapper.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/9/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Cocoa
import SwiftUI

class SystemInfoCoordinator: NSObject {
    var data: ViewModel

    init(data: ViewModel) {
        self.data = data
    }
}

struct LineChartViewControllerWrapper: NSViewControllerRepresentable {
    
    @ObservedObject var viewModel: ViewModel
    
    typealias NSViewControllerType = LineChartViewController
    typealias LineChartContext = NSViewControllerRepresentableContext<LineChartViewControllerWrapper>
    
    func makeNSViewController(context: LineChartContext) -> LineChartViewController {
        
        LineChartViewController()
    }
        
    func updateNSViewController(
        _ nsViewController: LineChartViewController, context: LineChartContext
    ) {
        guard let value = viewModel.sysInfo else { return }
        nsViewController.lastSystemInfo = value
    }
    
    func makeCoordinator() -> SystemInfoCoordinator {
        SystemInfoCoordinator(data: viewModel)
    }
    
}

