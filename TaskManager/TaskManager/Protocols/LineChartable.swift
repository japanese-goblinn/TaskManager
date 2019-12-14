//
//  Chartable.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/12/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import Charts

fileprivate class CustomYAxisFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))%"
    }
}

protocol LineChartable {
    
    var lineChartView: LineChartView! { get set }
    
    func setUpChart()
    
    func createChart(from data: [ChartDataEntry],
                     with color: NSColor,
                     and label: String) -> LineChartDataSet
    
    func updateChart()
    
}

extension LineChartable {
    
    func setUpChart() {
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.labelTextColor = .white
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.legend.enabled = false
        let y = lineChartView.leftAxis
        y.valueFormatter = CustomYAxisFormatter()
        y.axisMaximum = 100
        y.axisMinimum = 0
    }
    
    func createChart(from data: [ChartDataEntry],
                     with color: NSColor,
                     and label: String) -> LineChartDataSet {
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
}
