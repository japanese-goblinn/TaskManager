//
//  XPCService.m
//  XPCService
//
//  Created by Kirill Gorbachyonok on 12/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

class XPCServiceDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        let exportedObject = XPCService()
        newConnection.exportedInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        newConnection.exportedObject = exportedObject
        newConnection.resume()
        return true
    }
}
