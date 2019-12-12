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
        setUpChart()
        updateChart()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        lineChartView.animate(yAxisDuration: 0.5)
    }
}

extension MemoryChartViewController: LineChartable {
    
    func updateChart() {
        let memLine = createChart(
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
}
