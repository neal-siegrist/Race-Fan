//
//  StandingsCell.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/19/23.
//

import UIKit

class StandingsCell: UITableViewCell {

    //MARK: - Variables
    
    static let CONTENT_CONTAINER_PADDING = 5.0
    static let CONTENT_PADDING = 10.0
    static let CELL_ID = "StandingsCellIdentifier"
    static let TEAM_COLOR_WIDTH = 5.0
    
    let contentContainer: UIView = {
        let contentContainer = UIView()
        
        contentContainer.backgroundColor = .white
        
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return contentContainer
    }()
    
    let teamColorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
    
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let pointsLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .right
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        setupSubViews()
        
        setupTeamColorView()
        setupContentContainer()
        setupPositionLabel()
        setupNameLabel()
        setupPointsLabel()
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
    
    private func setupContentContainer() {
        
        NSLayoutConstraint.activate([
            self.contentContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: StandingsCell.CONTENT_CONTAINER_PADDING),
            self.contentContainer.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: StandingsCell.CONTENT_CONTAINER_PADDING),
            self.contentContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -StandingsCell.CONTENT_CONTAINER_PADDING),
            self.contentContainer.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -StandingsCell.CONTENT_CONTAINER_PADDING)
        ])
    }
    
    private func setupSubViews() {
        self.contentView.addSubview(contentContainer)
        
        contentContainer.addSubview(teamColorView)
        contentContainer.addSubview(positionLabel)
        contentContainer.addSubview(nameLabel)
        contentContainer.addSubview(pointsLabel)
    }
    
    private func setupTeamColorView() {
        NSLayoutConstraint.activate([
            teamColorView.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: StandingsCell.CONTENT_PADDING),
            teamColorView.leftAnchor.constraint(equalTo: contentContainer.leftAnchor, constant: StandingsCell.CONTENT_PADDING),
            teamColorView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -StandingsCell.CONTENT_PADDING),
            teamColorView.widthAnchor.constraint(equalToConstant: StandingsCell.TEAM_COLOR_WIDTH)
        ])
    }
    
    private func setupPositionLabel() {
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: self.contentContainer.topAnchor, constant: StandingsCell.CONTENT_PADDING),
            positionLabel.leftAnchor.constraint(equalTo: self.contentContainer.leftAnchor, constant: StandingsCell.CONTENT_PADDING),
            positionLabel.bottomAnchor.constraint(equalTo: self.contentContainer.bottomAnchor, constant: -StandingsCell.CONTENT_PADDING),
            positionLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentContainer.topAnchor, constant: StandingsCell.CONTENT_PADDING),
            nameLabel.leftAnchor.constraint(equalTo: positionLabel.rightAnchor, constant: StandingsCell.CONTENT_PADDING),
            nameLabel.bottomAnchor.constraint(equalTo: self.contentContainer.bottomAnchor, constant: -StandingsCell.CONTENT_PADDING),
            nameLabel.rightAnchor.constraint(equalTo: pointsLabel.leftAnchor, constant: -StandingsCell.CONTENT_PADDING)
        ])
    }
    
    private func setupPointsLabel() {
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: self.contentContainer.topAnchor, constant: StandingsCell.CONTENT_PADDING),
            pointsLabel.bottomAnchor.constraint(equalTo: self.contentContainer.bottomAnchor, constant: -StandingsCell.CONTENT_PADDING),
            pointsLabel.rightAnchor.constraint(equalTo: self.contentContainer.rightAnchor, constant: -StandingsCell.CONTENT_PADDING)
        ])
    }
}
