//
//  SystemInfo.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

struct SystemInfo {
    let userPercentageUsage: Float
    let systemPercentageUsage: Float
    let idlePercentageUsage: Float
    
    init(with value: Float) {
        userPercentageUsage = value
        systemPercentageUsage = value
        idlePercentageUsage = value
    }
    
    init(
        userPercentageUsage: Float,
        systemPercentageUsage: Float,
        idlePercentageUsage: Float
    ) {
        self.userPercentageUsage = userPercentageUsage
        self.systemPercentageUsage = systemPercentageUsage
        self.idlePercentageUsage = idlePercentageUsage
    }
    
}
