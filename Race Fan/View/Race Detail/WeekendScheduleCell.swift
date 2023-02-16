//
//  WeekendScheduleCell.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/24/23.
//

import UIKit

class WeekendScheduleCell: UITableViewCell {

    //MARK: - Variables
    
    static let CELL_IDENTIFIER = "WeekendScheduleCell"
    
    let contentContainer: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let calendarView: UIView = {
        let view = UIView()

        view.layer.cornerRadius = 5.0
        view.backgroundColor = .white
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.red.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let day: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.text = "10"
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let calendarDividerLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let month: UILabel = {
        let label = UILabel()

        label.textAlignment = .center
        label.text = "December"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let eventTitle: UILabel = {
        let label = UILabel()
        
        label.text = "Race"
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let eventStartTime: UILabel = {
        let label = UILabel()
        
        label.text = "10:00 PM"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        setupSubviews()
        
        setupContentContainer()
        setupCalendarView()
        setupEventTitle()
        setupEventStartTime()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentContainer.layoutIfNeeded()
        
        setupCellShadow()
    }
    
    
    //MARK: - Functions
    
    private func setupCellShadow() {
      
        contentContainer.layer.cornerRadius = 10.0
        
        contentContainer.layer.shadowColor = UIColor.black.cgColor
        contentContainer.layer.shadowRadius = 5.0
        contentContainer.layer.shadowOffset = CGSize.zero
        contentContainer.layer.shadowOpacity = 0.3
        
        contentContainer.layer.shadowPath = CGPath(roundedRect: contentContainer.bounds, cornerWidth: contentContainer.layer.cornerRadius, cornerHeight: contentContainer.layer.cornerRadius, transform: nil)
    }
    
    private func setupSubviews() {
        self.contentView.addSubview(contentContainer)
        
        contentContainer.addSubview(calendarView)
        
        calendarView.addSubview(day)
        calendarView.addSubview(month)
        calendarView.addSubview(calendarDividerLine)
        
        contentContainer.addSubview(eventTitle)
        contentContainer.addSubview(eventStartTime)
    }
    
    private func setupContentContainer() {
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            contentContainer.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            contentContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            contentContainer.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5)
        ])
    }
    
    private func setupCalendarView() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 10),
            calendarView.leftAnchor.constraint(equalTo: contentContainer.leftAnchor, constant: 10),
            calendarView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 60),
            calendarView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            day.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 7.5),
            day.centerXAnchor.constraint(equalTo: calendarView.centerXAnchor),
            day.leftAnchor.constraint(equalTo: calendarView.leftAnchor, constant: 5),
            day.rightAnchor.constraint(equalTo: calendarView.rightAnchor, constant: -5),
            calendarDividerLine.bottomAnchor.constraint(equalTo: month.topAnchor, constant: -2),
            calendarDividerLine.leftAnchor.constraint(equalTo: calendarView.leftAnchor),
            calendarDividerLine.rightAnchor.constraint(equalTo: calendarView.rightAnchor),
            calendarDividerLine.heightAnchor.constraint(equalToConstant: 1.0),
            month.bottomAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: -5),
            month.centerXAnchor.constraint(equalTo: calendarView.centerXAnchor),
            month.leftAnchor.constraint(equalTo: calendarView.leftAnchor, constant: 5),
            month.rightAnchor.constraint(equalTo: calendarView.rightAnchor, constant: -5)
        ])
    }
    
    private func setupEventTitle() {
        NSLayoutConstraint.activate([
            eventTitle.topAnchor.constraint(equalTo: calendarView.topAnchor),
            eventTitle.leftAnchor.constraint(equalTo: calendarView.rightAnchor, constant: 15)
        ])
    }
    
    private func setupEventStartTime() {
        NSLayoutConstraint.activate([
            eventStartTime.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 5),
            eventStartTime.leftAnchor.constraint(equalTo: calendarView.rightAnchor, constant: 15)
        ])
    }
}
