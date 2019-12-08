//
//  Pids.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/7/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import XPCService

class Parse {
    public static func getOutput() {
        let connection = NSXPCConnection(serviceName: "saisuicied.XPCService")
        connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        connection.resume()
        
        let service = connection.remoteObjectProxyWithErrorHandler { error in
            print("Received error:", error)
        } as? XPCServiceProtocol
        
        while (true) {
            service?.requestProcessesInfo { result in
                print(result)
            }
            sleep(2)
        }
    }
}
