//
//  Parse.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/7/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import XPCService

class Service {
        
    private static var regex = try? NSRegularExpression(pattern: "[0-9]{1,3}.[0-9]{1,}%")
    
    private static var service: XPCServiceProtocol? {
        let connection = NSXPCConnection(serviceName: "saisuicied.XPCService")
        connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        connection.resume()
        let service = connection.remoteObjectProxyWithErrorHandler { error in
            print("Received error:", error)
        } as? XPCServiceProtocol
        return service
    }
    
    private struct Parse {
        
        static func top(value: [String]) -> SystemInfo {
            let info = value.prefix(10)[3]
            guard let regex = Service.regex else { fatalError("REGEX ERROR") }
            let result = regex.match(this: info).map { $0.dropLast() }
            return SystemInfo(
                userPercentageUsage: Float(result[0])!,
                systemPercentageUsage: Float(result[1])!,
                idlePercentageUsage: Float(result[2])!
            )
        }
        
        static func ps(value: [String]) -> [Process] {
            value.dropFirst(1)
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
        }
    }
        
    static func systemInfoOutput(sleep value: UInt32,
                                 completion: @escaping (SystemInfo) -> Void) {
        while (true) {
            service?.request(command: "/usr/bin/top", with: ["-l", "1"]) { result in
                completion(Parse.top(value: result))
            }
            sleep(value)
        }
    }
    
    static func processesInfoOutput(sleep value: UInt32,
                                    completion: @escaping([Process]) -> Void) {
        while(true) {
            service?.request(command: "/bin/ps", with: ["aux", "-c"]) { result in
                completion(Parse.ps(value: result))
            }
            sleep(value)
        }
    }
    
    static func killProcess(by pid: Int,
                            failure: @escaping (Error?) -> Void) {
        service?.kill(by: pid) { error in
            failure(error)
        }
    }
}


