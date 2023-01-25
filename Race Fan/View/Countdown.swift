//
//  Countdown.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/7/23.
//

import UIKit

class Countdown: UIView {

    //MARK: - Variables
    
    let backgroundCircleColor: UIColor
    let progressCircleColor: UIColor
    
    var countdownCircle: ProgressCircle!
    
    let circleCountdownvalue: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let unitOfCountdown: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    //MARK: - Initializers

    init(backgroundCircleColor: UIColor, progressCircleColor: UIColor) {
        
        self.backgroundCircleColor = backgroundCircleColor
        self.progressCircleColor = progressCircleColor
        
        super.init(frame: .zero)
        
        self.countdownCircle = initializeCircle()
        
        self.addSubview(circleCountdownvalue)
        setupCountdownCircleConstraints()
        setupCountdownValueConstraints()
        setupUnitLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Adding Y constraint due to waiting for frame availability after circle radius/size is adjusted.
        circleCountdownvalue.centerYAnchor.constraint(equalTo: self.topAnchor, constant: (frame.height - unitOfCountdown.bounds.height) / 2.0).isActive = true
    }
    
    private func initializeCircle() -> ProgressCircle {
        let circle = ProgressCircle(backgroundCircleColor: self.backgroundCircleColor, progressCircleColor: self.progressCircleColor)
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        return circle
    }
    
    private func setupCountdownCircleConstraints() {
        self.addSubview(countdownCircle)
        
        NSLayoutConstraint.activate([
            countdownCircle.topAnchor.constraint(equalTo: self.topAnchor),
            countdownCircle.leftAnchor.constraint(equalTo: self.leftAnchor),
            countdownCircle.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    private func setupCountdownValueConstraints() {
        self.addSubview(circleCountdownvalue)
        
        NSLayoutConstraint.activate([
            circleCountdownvalue.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupUnitLabelConstraints() {
        self.addSubview(unitOfCountdown)
        
        NSLayoutConstraint.activate([
            unitOfCountdown.topAnchor.constraint(equalTo: countdownCircle.bottomAnchor),
            unitOfCountdown.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            unitOfCountdown.leftAnchor.constraint(equalTo: self.leftAnchor),
            unitOfCountdown.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
