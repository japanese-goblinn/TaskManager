//
//  NSRegualarExpressionExtension.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/9/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    
    func match(this string: String) -> [String] {
        let range = NSRange(location: 0, length: string.utf8.count)
        return self.matches(in: string, range: range)
            .map { string[$0.range] }
    }
}
