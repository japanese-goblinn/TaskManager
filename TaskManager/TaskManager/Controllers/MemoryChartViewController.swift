//
//  MemoryChartViewController.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/12/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Cocoa
import Charts

class MemoryChartViewController: NSViewController {
    
    @IBOutlet var lineChartView: LineChartView!
    
    private var memUsageSum = [Float](repeating: 0, count: 10)
    
    private var lastMemSum: Float = 0 {
        willSet {
            memUsageSum = memUsageSum.dropFirst(1).map { $0 }
            memUsageSum.append(newValue)
            updateChart()
        }
    }
    
    private class CustomYAxisFormatter: IAxisValueFormatter {
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return "\(Int(value))%"
        }
    }
    
    private func setUpPlot() {
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.leftAxis.labelTextColor = .white
        let y = lineChartView.leftAxis
        y.valueFormatter = CustomYAxisFormatter()
        y.axisMaximum = 100
        y.axisMinimum = 0
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
        let memLine = createPlot(
            from: memUsageSum
                .enumerated()
                .map { i, memPer in
                    ChartDataEntry(x: Double(i), y: Double(memPer))
                },
            with: .systemGreen,
            and: "Memory"
        )
        let data = LineChartData()
        data.addDataSet(memLine)
        lineChartView.data = data
    }
    
    private func observingProcessesInfo() {
        DispatchQueue.global().async {
            Service.processesInfoOutput(sleep: 2) { processes in
                DispatchQueue.main.async { [weak self] in
                    self?.lastMemSum = processes
                        .map { $0.memPercentage }
                        .reduce(0, +)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        observingProcessesInfo()
        setUpPlot()
        updateChart()
    }
    
}
