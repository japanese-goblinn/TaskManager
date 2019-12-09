//
//  StringExtension.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/9/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

extension String {
    
    subscript(range: NSRange) -> String {
        (self as NSString).substring(with: range)
    }
}
