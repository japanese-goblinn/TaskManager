//
//  main.m
//  XPCService
//
//  Created by Kirill Gorbachyonok on 12/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

let delegate = XPCServiceDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate
listener.resume()
