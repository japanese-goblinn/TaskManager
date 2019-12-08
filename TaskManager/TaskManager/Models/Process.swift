//
//  Process.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

struct Process {
    let pid: Int
    let name: String
    let cpuPercentage: Float
    let memPercentage: Float
    let time: String
    let state: String
    let user: String
}
