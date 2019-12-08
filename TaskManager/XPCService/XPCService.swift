//
//  XPCService.h
//  XPCService
//
//  Created by Kirill Gorbachyonok on 12/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

class XPCService: NSObject, XPCServiceProtocol {
    func requestProcessesInfo(completion: @escaping (String) -> Void) {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/top")
        process.arguments = ["-l", "1"]
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        do {
            try process.run()
        } catch {
            print(error.localizedDescription)
        }
        completion(String(decoding: outputPipe.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self))
    }
}
