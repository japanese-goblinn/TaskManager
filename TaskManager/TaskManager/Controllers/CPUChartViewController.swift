//
//  LineChartViewController.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/9/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import Cocoa
import Charts


class CPUChartViewController: NSViewController
{
    @IBOutlet var lineChartView: LineChartView!
    
    private lazy var sysUsage = [SystemInfo](
        repeating: SystemInfo(with: 0),
        count: 10
    )
    
    var lastSystemInfo: SystemInfo = SystemInfo(with: 0) {
        willSet {
            sysUsage = sysUsage.dropFirst(1).map { $0 }
            sysUsage.append(newValue)
            updateChart()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpChart()
        updateChart()
    }
    
    override func viewWillAppear()
    {
        self.lineChartView.animate(yAxisDuration: 0.5)
    }
}

extension CPUChartViewController: LineChartable {
    
    func updateChart() {
        let sysLine = createChart(
            from: sysUsage
                .enumerated()
                .map {
                    ChartDataEntry(x: Double($0), y: Double($1.systemPercentageUsage))
                },
            with: .systemRed,
            and: "System"
        )
        
        let userLine = createChart(
            from: sysUsage
                .enumerated()
                .map {
                    ChartDataEntry(x: Double($0), y: Double($1.userPercentageUsage))
                },
            with: .systemBlue,
            and: "User"
        )
        let data = LineChartData()
        data.addDataSet(sysLine)
        data.addDataSet(userLine)
        lineChartView.data = data
    }
}
