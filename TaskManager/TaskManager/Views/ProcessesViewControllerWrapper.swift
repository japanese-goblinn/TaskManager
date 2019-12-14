//
//  ProcessesViewControllerWrapper.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/9/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Cocoa
import SwiftUI

struct ProcessesViewControllerWrapper: NSViewControllerRepresentable {
        
    typealias NSViewControllerType = ProcessesViewController
    typealias ProcessesViewControllerContext = NSViewControllerRepresentableContext<ProcessesViewControllerWrapper>
    
    func makeNSViewController(context: ProcessesViewControllerContext) -> ProcessesViewController {
        ProcessesViewController()
    }
    
    func updateNSViewController(_ nsViewController: ProcessesViewController,
                                context: ProcessesViewControllerContext) {}
}
