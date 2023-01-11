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
    
    private var countdownTimer: Timer?
    private var totalSecondsRemaining: Int = 0 {
        didSet {
            updateUI()
        }
    }
    
    private var daysRemaining: Int  = 0 {
        didSet {
                dayProgress.circleCountdownvalue.text = String(daysRemaining)
                dayProgress.countdownCircle.setProgressRemaining(progress: CGFloat(Double(daysRemaining) / 120.0))
        }
    }
    
    private var hoursRemaining: Int  = 0 {
        didSet {
                hourProgress.circleCountdownvalue.text = String(hoursRemaining)
                hourProgress.countdownCircle.setProgressRemaining(progress: CGFloat(Double(hoursRemaining) / 24.0))
        }
    }
    
    private var minutesRemaining: Int  = 0 {
        didSet {
                minuteProgress.circleCountdownvalue.text = String(minutesRemaining)
                minuteProgress.countdownCircle.setProgressRemaining(progress: CGFloat(Double(minutesRemaining) / 60.0))
        }
    }
    
    private var secondsRemaining: Int  = 0 {
        didSet {
                secondProgress.circleCountdownvalue.text = String(secondsRemaining)
                secondProgress.countdownCircle.setProgressRemaining(progress: CGFloat(Double(secondsRemaining) / 60.0))
        }
    }
    
    var dayProgress: Countdown = {
        let countdown = Countdown()
        countdown.unitOfCountdown.text = "Days"
        
        countdown.translatesAutoresizingMaskIntoConstraints = false
        return countdown
    }()
    
    var hourProgress: Countdown = {
        let countdown = Countdown()
        countdown.unitOfCountdown.text = "Hours"
        
        countdown.translatesAutoresizingMaskIntoConstraints = false
        return countdown
    }()
    
    var minuteProgress: Countdown = {
        let countdown = Countdown()
        countdown.unitOfCountdown.text = "Minutes"
        
        countdown.translatesAutoresizingMaskIntoConstraints = false
        return countdown
    }()
    
    var secondProgress: Countdown = {
        let countdown = Countdown()
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
    
    func startTimer(withSecondsRemaining: Int) {
        guard withSecondsRemaining > 0 else { return }
        if let timer = countdownTimer { timer.invalidate() }
        
        self.totalSecondsRemaining = withSecondsRemaining
        
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeRemaining), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimeRemaining() {

        if totalSecondsRemaining <= 0 {
            self.countdownTimer?.invalidate()
        } else {
            totalSecondsRemaining -= 1
        }
    }
    
    private func updateUI() {
        daysRemaining = totalSecondsRemaining / CountdownUnit.days.rawValue
        
        let remainingSecondsAfterDays = totalSecondsRemaining % CountdownUnit.days.rawValue
        hoursRemaining = remainingSecondsAfterDays / CountdownUnit.hours.rawValue
   
        
        let remainingSecondsAfterHours = remainingSecondsAfterDays % CountdownUnit.hours.rawValue
        minutesRemaining = remainingSecondsAfterHours / CountdownUnit.minutes.rawValue
  
        
        let remainingSecondsAfterMinutes = remainingSecondsAfterHours % CountdownUnit.minutes.rawValue
        secondsRemaining =  remainingSecondsAfterMinutes / CountdownUnit.seconds.rawValue
    }
}

enum CountdownUnit: Int {
    case days = 86400
    case hours = 3600
    case minutes = 60
    case seconds = 1
}
