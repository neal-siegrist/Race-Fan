//
//  ScheduleView.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/16/23.
//

import UIKit

class ToggleListView: UIView {

    //MARK: - Variables
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        
        control.selectedSegmentTintColor = .red
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.sectionHeaderTopPadding = 0.0
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        setupSegmentedControl()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    private func setupSegmentedControl() {
        self.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leftAnchor.constraint(equalTo: self.leftAnchor),
            segmentedControl.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}
