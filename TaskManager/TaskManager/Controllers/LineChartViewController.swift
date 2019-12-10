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
    @IBOutlet var barChartView: BarChartView!
    
    private lazy var sysUsage = [SystemInfo]()
    
    var lastSystemInfo: SystemInfo = SystemInfo(
        userPercentageUsage: 0, systemPercentageUsage: 0, idlePercentageUsage: 100
    ) {
        
        willSet {
            if sysUsage.count == 10 {
                sysUsage = sysUsage.dropFirst(1).map { $0 }
            }
            sysUsage.append(newValue)
            dump(sysUsage)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let xArray = Array(1..<10)
        print(xArray.count)
        let ys1 = xArray.map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        let ys2 = xArray.map { x in return cos(Double(x) / 2.0 / 3.141) }
        
        let yse1 = ys1.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
        let yse2 = ys2.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
        
        let data = BarChartData()
        let ds1 = BarChartDataSet(entries: yse1, label: "System")
        ds1.colors = [.red]
        data.addDataSet(ds1)

        let ds2 = BarChartDataSet(entries: yse2, label: "User")
        ds2.colors = [.blue]
        data.addDataSet(ds2)

        let barWidth = 0.4
        let barSpace = 0.05
        let groupSpace = 0.1
        
        data.barWidth = barWidth
        self.barChartView.xAxis.axisMinimum = Double(xArray[0])
        self.barChartView.xAxis.axisMaximum = Double(xArray[0]) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(xArray.count)
        // (0.4 + 0.05) * 2 (data set count) + 0.1 = 1
        data.groupBars(fromX: Double(xArray[0]), groupSpace: groupSpace, barSpace: barSpace)

        self.barChartView.data = data
    
        self.barChartView.gridBackgroundColor = .clear
        
    }
    
    override func viewWillAppear()
    {
        self.barChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    private func setChart() {
        
    }
}
