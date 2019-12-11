//
//  ProcessesViewController.swift
//  TaskManager
//
//  Created by Kirill Gorbachyonok on 12/9/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Cocoa

class ProcessesViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
        
    private var processes: [Process]? {
        willSet {
            tableView.reloadData()
        }
    }
    
    private func observingProcessesInfo() {
        DispatchQueue.global().async {
            Service.processesInfoOutput(sleep: 2) { processes in
                DispatchQueue.main.async { [weak self] in
                    self?.processes = processes
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        observingProcessesInfo()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProcessesViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return processes?.count ?? 0
    }
}

extension ProcessesViewController: NSTableViewDelegate {
    
    private enum CellIdentifiers {
        static let pidCell = "pidCellId"
        static let nameCell = "nameCellId"
        static let cpuCell = "cpuPercentageCellId"
        static let cpuTimeCell = "cpuTimeCellId"
        static let memCell = "memPercentageCellId"
        static let stateCell = "stateCellId"
        static let userCell = "userCellId"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String = ""
        var cellIdentifier: String = ""

        guard
            processes?.indices.contains(row) ?? false,
            let item = processes?[row]
        else {
            return nil
        }
        
        if tableColumn == tableView.tableColumns[0] {
            text = "\(item.pid)"
            cellIdentifier = CellIdentifiers.pidCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.name
            cellIdentifier = CellIdentifiers.nameCell
        } else if tableColumn == tableView.tableColumns[2] {
            text = "\(item.cpuPercentage)"
            cellIdentifier = CellIdentifiers.cpuCell
        } else if tableColumn == tableView.tableColumns[3] {
            text = "\(item.time)"
            cellIdentifier = CellIdentifiers.cpuTimeCell
        } else if tableColumn == tableView.tableColumns[4] {
            text = "\(item.memPercentage)"
            cellIdentifier = CellIdentifiers.memCell
        } else if tableColumn == tableView.tableColumns[5] {
            text = "\(item.state)"
            cellIdentifier = CellIdentifiers.stateCell
        } else if tableColumn == tableView.tableColumns[6] {
            text = "\(item.user)"
            cellIdentifier = CellIdentifiers.userCell
        }
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView
        else {
            return nil
        }
        cell.textField?.stringValue = text
        return cell
    }
}
