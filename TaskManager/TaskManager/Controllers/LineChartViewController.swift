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

final class LineChartViewController: NSViewController
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
        updateChart()
    }
    
    override func viewWillAppear()
    {
        self.lineChartView.animate(yAxisDuration: 0.5)
    }
    
    private func createPlot(
        from data: [ChartDataEntry], with color: NSColor, and label: String
    ) -> LineChartDataSet {
        
        let line = LineChartDataSet(entries: data, label: label)
        line.mode = .cubicBezier
        line.cubicIntensity = 0.2
        line.fill = Fill(color: color)
        line.colors = [color]
        line.drawFilledEnabled = true
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false
        return line
    }
    
    private func updateChart() {
        let sysLine = createPlot(
            from: sysUsage
                .enumerated()
                .map {
                    ChartDataEntry(x: Double($0), y: Double($1.systemPercentageUsage))
                },
            with: .systemRed,
            and: "System"
        )
        
        let userLine = createPlot(
            from: sysUsage
                .enumerated()
                .map {
                    ChartDataEntry(x: Double($0), y: Double($1.userPercentageUsage))
                },
            with: .systemBlue,
            and: "User"
        )
        
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.enabled = false
        let y = lineChartView.leftAxis
        y.axisMaximum = 100
        y.axisMinimum = 0

        let data = LineChartData()
        data.addDataSet(sysLine)
        data.addDataSet(userLine)
        lineChartView.data = data
    }
}
