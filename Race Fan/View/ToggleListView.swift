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
        tableView.isHidden = true
        tableView.sectionHeaderTopPadding = 0.0
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let noTableDataView: UIStackView = {
        let stack = UIStackView()
        let imgView = UIImageView()
        let message = UILabel()
        
        imgView.tag = 1
        message.tag = 2
        
        stack.axis = .horizontal
        stack.spacing = 10.0
        
        imgView.image = UIImage(systemName: "xmark.octagon")
        imgView.tintColor = .red
        
        message.text = "Check back!"
        
        stack.addArrangedSubview(imgView)
        stack.addArrangedSubview(message)
        
        stack.isHidden = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let loadingWheel: UIActivityIndicatorView = {
        let loadingWheel = UIActivityIndicatorView()
        loadingWheel.color = .red
        loadingWheel.isHidden = true
        loadingWheel.translatesAutoresizingMaskIntoConstraints = false
        return loadingWheel
    }()
    
    
    //MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        setupSegmentedControl()
        setupTableView()
        setupNoTableDataView()
        setupLoadingWheel()
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
    
    private func setupNoTableDataView() {
        self.addSubview(noTableDataView)
        
        NSLayoutConstraint.activate([
            noTableDataView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            noTableDataView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupLoadingWheel() {
        self.addSubview(loadingWheel)
        
        NSLayoutConstraint.activate([
            loadingWheel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingWheel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func shouldHideTableView(shouldHide: Bool) {
        self.tableView.isHidden = shouldHide
        self.noTableDataView.isHidden = !shouldHide
    }
    
    func setErrorMessage(_ message: String) {
        if let messageLabel = noTableDataView.viewWithTag(2) as? UILabel {
            messageLabel.text = message
        }
    }
}
