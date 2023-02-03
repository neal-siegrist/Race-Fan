//
//  TopDriverStandingsView.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/28/23.
//

import UIKit

class TopStandingsView: UIView {
    
    //MARK: - Variables
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isUserInteractionEnabled = false
        
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
        self.layer.cornerRadius = 10.0
        
        setupTitleLabel()
        setupTableView()
        setupNoTableDataView()
        setupLoadingWheel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 5)
        ])
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -5)
        ])
    }
    
    private func setupNoTableDataView() {
        self.addSubview(noTableDataView)
        
        NSLayoutConstraint.activate([
            noTableDataView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
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
