//
//  XPCServiceProtocol.h
//  XPCService
//
//  Created by Kirill Gorbachyonok on 12/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

@objc public protocol XPCServiceProtocol {
    func requestProcessesInfo(completion: @escaping (String) -> Void)
}
