//
//  MemoryChartViewControllerWrapper.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/12/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryChartViewControllerWrapper: NSViewControllerRepresentable {
    
    func makeNSViewController(
        context: MemoryChartViewControllerContext
    ) -> MemoryChartViewController {
        MemoryChartViewController()
    }
    
    func updateNSViewController(
        _ nsViewController: MemoryChartViewController,
        context: MemoryChartViewControllerContext
    ) {}
}

extension MemoryChartViewControllerWrapper {
    typealias NSViewControllerType = MemoryChartViewController
    typealias MemoryChartViewControllerContext = NSViewControllerRepresentableContext<MemoryChartViewControllerWrapper>
}
