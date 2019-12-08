//
//  Parse.swift
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
        
        service?.request(command: "/usr/bin/top", with: ["-l", "1"]) {
            result in
        
            parseTop(value: result)
        }
        
        service?.request(command: "/bin/ps", with: ["aux", "-c"]) {
            result in
            
            parsePs(value: result)
        }

//        while (true) {
//            service?.requestProcessesInfo { result in
//                parse(value: result)
//            }
//            sleep(2)
//        }
    }
    
    private static func parseTop(value: [String]) {
        let info = value.prefix(10)[3]
        
        //TODO: parse usefull info
        
        dump(info)
    }
    
    private static func parsePs(value: [String]) {
        let processes = value
            .dropFirst(1)
            .map {
                $0.components(separatedBy: .whitespaces)
                    .filter { $0 != "" }
            }.map {
                Process(
                    pid: Int($0[1])!,
                    name: $0[10],
                    cpuPercentage: Float($0[2])!,
                    memPercentage: Float($0[3])!,
                    time: $0[9],
                    state: $0[7],
                    user: $0[0]
                )
        }
        dump(processes)
    }
}


