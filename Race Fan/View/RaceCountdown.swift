//
//  RaceCountdown.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/6/23.
//

import UIKit

class RaceCountdown: UIStackView {
    
    //MARK: - Variables
    
    private static let SINGLE_COUNTDOWN_WIDTH = UIScreen.main.bounds.width / 5
    private static let SINGLE_COUNTDOWN_HEIGHT = RaceCountdown.SINGLE_COUNTDOWN_WIDTH + 20
    
    var dayProgress: Countdown = {
        let countdown = Countdown(progress: 0.1)
        
        //Temporary dummy data.
        countdown.circleCountdownvalue.text = "4"
        countdown.unitOfCountdown.text = "Days"
        
        countdown.translatesAutoresizingMaskIntoConstraints = false
        return countdown
    }()
    
    var hourProgress: Countdown = {
        let countdown = Countdown(progress: 0.3)
        
        //Temporary dummy data.
        countdown.circleCountdownvalue.text = "8"
        countdown.unitOfCountdown.text = "Hours"
        
        countdown.translatesAutoresizingMaskIntoConstraints = false
        return countdown
    }()
    
    var minuteProgress: Countdown = {
        let countdown = Countdown(progress: 0.35)
        
        //Temporary dummy data.
        countdown.circleCountdownvalue.text = "33"
        countdown.unitOfCountdown.text = "Minutes"
        
        countdown.translatesAutoresizingMaskIntoConstraints = false
        return countdown
    }()
    
    var secondProgress: Countdown = {
        let countdown = Countdown(progress: 0.15)
        
        //Temporary dummy data.
        countdown.circleCountdownvalue.text = "12"
        countdown.unitOfCountdown.text = "Seconds"
        
        countdown.translatesAutoresizingMaskIntoConstraints = false
        return countdown
    }()

    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackViewAndConstraints()
        setupDayProgressViewAndConstraints()
        setupHourProgressViewAndConstraints()
        setupMinuteProgressViewAndConstraints()
        setupSecondProgressViewAndConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    private func setupStackViewAndConstraints() {
        self.alignment = .center
        self.distribution = .equalSpacing
        self.axis = .horizontal
    }
    
    private func setupDayProgressViewAndConstraints() {
        self.addArrangedSubview(dayProgress)
        
        NSLayoutConstraint.activate([
            dayProgress.heightAnchor.constraint(equalToConstant: RaceCountdown.SINGLE_COUNTDOWN_HEIGHT),
            dayProgress.widthAnchor.constraint(equalToConstant: RaceCountdown.SINGLE_COUNTDOWN_WIDTH)
        ])
    }
    
    private func setupHourProgressViewAndConstraints() {
        self.addArrangedSubview(hourProgress)
        
        NSLayoutConstraint.activate([
            hourProgress.heightAnchor.constraint(equalToConstant: RaceCountdown.SINGLE_COUNTDOWN_HEIGHT),
            hourProgress.widthAnchor.constraint(equalToConstant: RaceCountdown.SINGLE_COUNTDOWN_WIDTH)
        ])
    }
    
    private func setupMinuteProgressViewAndConstraints() {
        self.addArrangedSubview(minuteProgress)
        
        NSLayoutConstraint.activate([
            minuteProgress.heightAnchor.constraint(equalToConstant: RaceCountdown.SINGLE_COUNTDOWN_HEIGHT),
            minuteProgress.widthAnchor.constraint(equalToConstant: RaceCountdown.SINGLE_COUNTDOWN_WIDTH)
        ])
    }
    
    private func setupSecondProgressViewAndConstraints() {
        self.addArrangedSubview(secondProgress)
        
        NSLayoutConstraint.activate([
            secondProgress.heightAnchor.constraint(equalToConstant: RaceCountdown.SINGLE_COUNTDOWN_HEIGHT),
            secondProgress.widthAnchor.constraint(equalToConstant: RaceCountdown.SINGLE_COUNTDOWN_WIDTH)
        ])
    }
}
