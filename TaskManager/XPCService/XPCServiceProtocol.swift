//
//  XPCServiceProtocol.h
//  XPCService
//
//  Created by Kirill Gorbachyonok on 12/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

@objc public protocol XPCServiceProtocol {
    
    func kill(by pid: Int)
    
    func request(command: String, with arguments: [String], completion: @escaping ([String]) -> Void)

}
