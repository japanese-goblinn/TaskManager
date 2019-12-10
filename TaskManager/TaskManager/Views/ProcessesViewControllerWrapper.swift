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
    func makeNSViewController(context: NSViewControllerRepresentableContext<ProcessesViewControllerWrapper>) -> NSViewController {
        ProcessesViewController()
    }
    
    func updateNSViewController(_ nsViewController: NSViewController, context: NSViewControllerRepresentableContext<ProcessesViewControllerWrapper>) {
        //
    }
    
    typealias NSViewControllerType = NSViewController

}
