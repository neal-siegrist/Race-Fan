//
//  ScheduleCell.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/16/23.
//

import UIKit

class ScheduleCell: UITableViewCell {

    //MARK: - Variables
    
    static let CONTENT_CONTAINER_PADDING = 10.0
    static let CONTENT_PADDING = 10.0
    static let CELL_ID = "ScheduleCellIdentifier"
    
    let contentContainer: UIView = {
        let contentContainer = UIView()
        
        contentContainer.backgroundColor = .white
        
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return contentContainer
    }()
    
    let roundLabel: UILabel = {
        let roundLabel = UILabel()
        
        roundLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return roundLabel
    }()
    
    let grandPrixNameLabel: UILabel = {
        let grandPrixNameLabel = UILabel()
        
        grandPrixNameLabel.numberOfLines = 0
        grandPrixNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return grandPrixNameLabel
    }()
    
    let locationStack: UIStackView = {
        let locationStack = UIStackView()
        
        locationStack.axis = .horizontal
        locationStack.spacing = 10.0
        
        locationStack.translatesAutoresizingMaskIntoConstraints = false
        
        return locationStack
    }()
    
    let locationPin: UIImageView = {
        let locationPin = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
        locationPin.tintColor = .red
        return locationPin
    }()
    
    let locationLabel: UILabel = {
        let locationLabel = UILabel()
        
        locationLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return locationLabel
    }()
    
    let raceDateLabel: UILabel = {
        let raceDateLabel = UILabel()
        
        raceDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        raceDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return raceDateLabel
    }()
    
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        setupSubViews()
        
        setupContentContainer()
        setupRoundLabel()
        setupGrandPrixNameLabel()
        setupLocation()
        setupRaceDateLabel()
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
    
    private func setupSubViews() {
        locationStack.addArrangedSubview(locationPin)
        locationStack.addArrangedSubview(locationLabel)
        
        self.contentView.addSubview(contentContainer)
        self.contentContainer.addSubview(roundLabel)
        self.contentContainer.addSubview(grandPrixNameLabel)
        self.contentContainer.addSubview(locationStack)
        self.contentContainer.addSubview(raceDateLabel)
    }
    
    private func setupContentContainer() {
        
        NSLayoutConstraint.activate([
            self.contentContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: ScheduleCell.CONTENT_CONTAINER_PADDING),
            self.contentContainer.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: ScheduleCell.CONTENT_CONTAINER_PADDING),
            self.contentContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -ScheduleCell.CONTENT_CONTAINER_PADDING),
            self.contentContainer.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -ScheduleCell.CONTENT_CONTAINER_PADDING)
        ])
    }
    
    private func setupRoundLabel() {
        NSLayoutConstraint.activate([
            roundLabel.topAnchor.constraint(equalTo: self.contentContainer.topAnchor, constant: ScheduleCell.CONTENT_PADDING),
            roundLabel.leftAnchor.constraint(equalTo: self.contentContainer.leftAnchor, constant: ScheduleCell.CONTENT_PADDING),
            roundLabel.rightAnchor.constraint(lessThanOrEqualTo: raceDateLabel.leftAnchor, constant: -5),
        ])
    }
    
    private func setupGrandPrixNameLabel() {
        NSLayoutConstraint.activate([
            grandPrixNameLabel.topAnchor.constraint(equalTo: roundLabel.bottomAnchor, constant: 5),
            grandPrixNameLabel.leftAnchor.constraint(equalTo: self.contentContainer.leftAnchor, constant: ScheduleCell.CONTENT_PADDING),
            grandPrixNameLabel.rightAnchor.constraint(lessThanOrEqualTo: raceDateLabel.leftAnchor, constant: -5)
        ])
    }
    
    private func setupLocation() {
        NSLayoutConstraint.activate([
            locationStack.topAnchor.constraint(equalTo: grandPrixNameLabel.bottomAnchor, constant: 5),
            locationStack.leftAnchor.constraint(equalTo: self.contentContainer.leftAnchor, constant: ScheduleCell.CONTENT_PADDING),
            locationStack.rightAnchor.constraint(lessThanOrEqualTo: raceDateLabel.leftAnchor, constant: -5),
            locationStack.bottomAnchor.constraint(equalTo: self.contentContainer.bottomAnchor, constant: -ScheduleCell.CONTENT_PADDING)
        ])
    }
    
    private func setupRaceDateLabel() {
        NSLayoutConstraint.activate([
            raceDateLabel.topAnchor.constraint(equalTo: self.contentContainer.topAnchor, constant: ScheduleCell.CONTENT_PADDING),
            raceDateLabel.rightAnchor.constraint(equalTo: self.contentContainer.rightAnchor, constant: -ScheduleCell.CONTENT_PADDING),
            raceDateLabel.bottomAnchor.constraint(equalTo: self.contentContainer.bottomAnchor, constant: -ScheduleCell.CONTENT_PADDING)
        ])
    }
}
