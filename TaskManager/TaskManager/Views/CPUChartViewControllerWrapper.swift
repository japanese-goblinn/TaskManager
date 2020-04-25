//
//  LineChartViewControllerWrapper.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/9/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Cocoa
import SwiftUI

class SystemCoordinator: NSObject {
    
    var data: ViewModel

    init(data: ViewModel) {
        self.data = data
    }
}

struct CPUChartViewControllerWrapper: NSViewControllerRepresentable {
    
    @ObservedObject var viewModel: ViewModel
    
    func makeNSViewController(context: LineChartContext) -> CPUChartViewController {
        CPUChartViewController()
    }
        
    func updateNSViewController(
        _ nsViewController: CPUChartViewController,
        context: LineChartContext
    ) {
        guard let value = viewModel.sysInfo else { return }
        nsViewController.lastSystemInfo = value
    }
    
    func makeCoordinator() -> SystemCoordinator {
        SystemCoordinator(data: viewModel)
    }
    
}

extension CPUChartViewControllerWrapper {
    typealias NSViewControllerType = CPUChartViewController
    typealias LineChartContext = NSViewControllerRepresentableContext<CPUChartViewControllerWrapper>
}

