//
//  XPCService.h
//  XPCService
//
//  Created by Kirill Gorbachyonok on 12/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

class XPCService: NSObject, XPCServiceProtocol {
    
    func kill(
        by pid: Int,
        failure: (Error?) -> Void
    ) {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/bash")
        process.arguments = ["-c", "kill -9 \(pid)"]
        do {
            try process.run()
            failure(nil)
        } catch {
            failure(error)
        }
    }
    
    func request(
        command: String,
        with arguments: [String],
        completion: @escaping ([String]) -> Void
    ) {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: command)
        process.arguments = arguments
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        do {
            try process.run()
        } catch {
            print(error.localizedDescription)
        }
        completion(
            String(
                decoding: outputPipe.fileHandleForReading.readDataToEndOfFile(),
                as: UTF8.self
            )
            .components(separatedBy: .newlines)
            .filter { $0 != "" }
        )
    }
}
