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
    
    private static var regex = try? NSRegularExpression(pattern: "[0-9]{1,3}.[0-9]{1,}%")
    
    static func getOutput() {
        let connection = NSXPCConnection(serviceName: "saisuicied.XPCService")
        connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        connection.resume()
        
        let service = connection.remoteObjectProxyWithErrorHandler { error in
            print("Received error:", error)
        } as? XPCServiceProtocol
        
//        service?.kill(by: 88532)
        
//
//        service?.request(command: "/bin/ps", with: ["aux", "-c"]) {
//            result in
//
//            parsePs(value: result)
//        }

        while (true) {
            service?.request(command: "/usr/bin/top", with: ["-l", "1"]) {
                result in
                
                parseTop(value: result)
            }
            sleep(1)
        }
    }
    
    private static func parseTop(value: [String]) {
        let info = value.prefix(10)[3]
        guard let regex = Parse.regex else { fatalError("REGEX ERROR") }
        let result = regex.match(this: info)
        dump(SystemInfo(userUsage: result[0], systemUsage: result[1], idleUsage: result[2]))
    }
    
    private static func parsePs(value: [String]) {
        let processes = value
            .dropFirst(1)
            .map {
                $0.components(separatedBy: .whitespaces)
                    .filter { $0 != "" }
            }
            .map {
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


