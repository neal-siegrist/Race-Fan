//
//  RaceDetailView.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/24/23.
//

import UIKit

class RaceDetailView: UIView {

    //MARK: - Variables
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let raceTitle: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let locationStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 10.0
        stack.alignment = .center
        
        stack.isHidden = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let locationPin: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        imageView.tintColor = .red
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let location: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let titleAndCountdownDivider: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let countdownTimer: RaceCountdown = {
        let countdown = RaceCountdown(backgroundCircleColor: UIColor.lightGray, progressCircleColor: UIColor.red)

        countdown.isHidden = true
        countdown.translatesAutoresizingMaskIntoConstraints = false

        return countdown
    }()
    
    let timeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["My Time", "Track Time"])
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .red
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    let weekendScheduleTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.sectionHeaderTopPadding = 0.0
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let scheduleAndCircuitDivider: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let circuitName: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupSubviews()
        
        setupScrollView()
        
        setupRaceTitle()
        setupLocation()
        setuptitleAndCountdownDivider()
        
        setupRaceCountdown()
        setupSegmentedControl()
        setupWeekendTableView()
        
        setupScheduleAndCircuitDivider()
        
        setupCircuitName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions

    private func setupSubviews() {
        self.addSubview(scrollView)
        
        scrollView.addSubview(raceTitle)
        
        locationStack.addArrangedSubview(locationPin)
        locationStack.addArrangedSubview(location)
        scrollView.addSubview(locationStack)
        
        scrollView.addSubview(titleAndCountdownDivider)
        scrollView.addSubview(countdownTimer)
        
        scrollView.addSubview(timeSegmentedControl)
        scrollView.addSubview(weekendScheduleTableView)
        
        scrollView.addSubview(scheduleAndCircuitDivider)
        
        scrollView.addSubview(circuitName)
    }
    
    private func setupScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setupRaceTitle() {
        NSLayoutConstraint.activate([
            raceTitle.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 10),
            raceTitle.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 10),
            raceTitle.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -10),
            raceTitle.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -20)
        ])
    }
    
    private func setupLocation() {
        NSLayoutConstraint.activate([
            locationStack.topAnchor.constraint(equalTo: raceTitle.bottomAnchor, constant: 10),
            locationStack.widthAnchor.constraint(lessThanOrEqualTo: scrollView.frameLayoutGuide.widthAnchor, constant: -20),
            locationStack.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setuptitleAndCountdownDivider() {
        NSLayoutConstraint.activate([
            titleAndCountdownDivider.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 10.0),
            titleAndCountdownDivider.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 5),
            titleAndCountdownDivider.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -5),
            titleAndCountdownDivider.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }
    
    private func setupRaceCountdown() {
        NSLayoutConstraint.activate([
            countdownTimer.topAnchor.constraint(equalTo: titleAndCountdownDivider.bottomAnchor, constant: 20),
            countdownTimer.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 10),
            countdownTimer.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -10),
            countdownTimer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -20)
        ])
    }
    
    private func setupSegmentedControl() {
        NSLayoutConstraint.activate([
            timeSegmentedControl.topAnchor.constraint(equalTo: countdownTimer.bottomAnchor, constant: 50),
            timeSegmentedControl.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 10),
            timeSegmentedControl.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -10)
        ])
    }
    
    private func setupWeekendTableView() {
        NSLayoutConstraint.activate([
            weekendScheduleTableView.topAnchor.constraint(equalTo: timeSegmentedControl.bottomAnchor, constant: 10),
            weekendScheduleTableView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 10),
            weekendScheduleTableView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -10),
            weekendScheduleTableView.heightAnchor.constraint(equalToConstant: 465)
        ])
    }
    
    private func setupScheduleAndCircuitDivider() {
        NSLayoutConstraint.activate([
            scheduleAndCircuitDivider.topAnchor.constraint(equalTo: weekendScheduleTableView.bottomAnchor, constant: 10),
            scheduleAndCircuitDivider.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 10),
            scheduleAndCircuitDivider.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -10),
            scheduleAndCircuitDivider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupCircuitName() {
        NSLayoutConstraint.activate([
            circuitName.topAnchor.constraint(equalTo: scheduleAndCircuitDivider.bottomAnchor, constant: 20),
            circuitName.leftAnchor.constraint(equalTo: scheduleAndCircuitDivider.leftAnchor, constant: 10),
            circuitName.rightAnchor.constraint(equalTo: scheduleAndCircuitDivider.rightAnchor, constant: -10),
            circuitName.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
}
