//
//  HomePageView.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/5/23.
//

import UIKit

class HomePageView: UIView {

    //MARK: - Properties
    
    let nextRaceBackground: UIView = {
        let view = UIView()
        
        view.backgroundColor = .red
        view.layer.cornerRadius = 20.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        return view
    }()
    
    let nextRaceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Next Race"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nextRaceDate: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let nextRaceTitle: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let raceCountdown: RaceCountdown = {
        let countown = RaceCountdown(frame: UIScreen.main.bounds)
        
        countown.translatesAutoresizingMaskIntoConstraints = false
        
        return countown
    }()
    
    let locationStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 10.0
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .lightGray
        
        setupNextRaceBackground()
        setupNextRaceLabel()
        setupNextRaceDateLabel()
        setupNextRaceTitle()
        setupCountdownTimer()
        setupLocationStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    private func setupNextRaceBackground() {
        self.addSubview(nextRaceBackground)
        
        NSLayoutConstraint.activate([
            nextRaceBackground.topAnchor.constraint(equalTo: self.topAnchor),
            nextRaceBackground.leftAnchor.constraint(equalTo: self.leftAnchor),
            nextRaceBackground.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    private func setupNextRaceLabel() {
        nextRaceBackground.addSubview(nextRaceLabel)
        
        NSLayoutConstraint.activate([
            nextRaceLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            nextRaceLabel.leftAnchor.constraint(equalTo: nextRaceBackground.leftAnchor, constant: 5)
        ])
    }
    
    private func setupNextRaceDateLabel() {
        nextRaceBackground.addSubview(nextRaceDate)
        
        NSLayoutConstraint.activate([
            nextRaceDate.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            nextRaceDate.rightAnchor.constraint(equalTo: nextRaceBackground.rightAnchor, constant: -5)
        ])
    }
    
    private func setupNextRaceTitle() {
        nextRaceBackground.addSubview(nextRaceTitle)
        
        NSLayoutConstraint.activate([
            nextRaceTitle.topAnchor.constraint(equalTo: nextRaceLabel.bottomAnchor, constant: 10),
            nextRaceTitle.leadingAnchor.constraint(equalTo: nextRaceBackground.leadingAnchor, constant: 10),
            nextRaceTitle.trailingAnchor.constraint(equalTo: nextRaceBackground.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupCountdownTimer() {
        nextRaceBackground.addSubview(raceCountdown)

        NSLayoutConstraint.activate([
            raceCountdown.topAnchor.constraint(equalTo: nextRaceTitle.bottomAnchor, constant: 20),
            raceCountdown.leftAnchor.constraint(equalTo: nextRaceBackground.leftAnchor, constant: 25),
            raceCountdown.rightAnchor.constraint(equalTo: nextRaceBackground.rightAnchor, constant: -25)
        ])
    }
    
    private func setupLocationStack() {
        nextRaceBackground.addSubview(locationStack)
        
        let locationPin = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
        
        locationStack.addArrangedSubview(locationPin)
        locationStack.addArrangedSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationStack.topAnchor.constraint(equalTo: raceCountdown.bottomAnchor, constant: 20),
            locationStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            locationStack.bottomAnchor.constraint(equalTo: nextRaceBackground.bottomAnchor,constant: -20)
        ])
    }
}
