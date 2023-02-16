//
//  ConstructorDetailView.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/23/23.
//

import UIKit

class ConstructorDetailView: UIView {

    //MARK: - Variables
    
    static let TEAM_COLOR_WIDTH = 5.0
    static let HORIZONTAL_PADDING: CGFloat = 15
    
    let teamColor: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        nameLabel.isHidden = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let nationalityStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.isHidden = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let nationalityLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        
        label.text = "Nationality"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nationality: UILabel = {
        let dateOfBirth = UILabel()
        
        dateOfBirth.textAlignment = .left
        dateOfBirth.numberOfLines = 0
        dateOfBirth.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        dateOfBirth.translatesAutoresizingMaskIntoConstraints = false
        
        return dateOfBirth
    }()

    let positionStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.isHidden = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        
        label.text = "Position"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let position: UILabel = {
        let dateOfBirth = UILabel()
        
        dateOfBirth.textAlignment = .left
        dateOfBirth.numberOfLines = 0
        dateOfBirth.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        dateOfBirth.translatesAutoresizingMaskIntoConstraints = false
        
        return dateOfBirth
    }()
    
    let pointsStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.isHidden = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        
        label.text = "Points"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let points: UILabel = {
        let dateOfBirth = UILabel()
        
        dateOfBirth.textAlignment = .left
        dateOfBirth.numberOfLines = 0
        dateOfBirth.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        dateOfBirth.translatesAutoresizingMaskIntoConstraints = false
        
        return dateOfBirth
    }()
    
    let winsStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.isHidden = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let winsLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        
        label.text = "Wins"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let wins: UILabel = {
        let dateOfBirth = UILabel()
        
        dateOfBirth.textAlignment = .left
        dateOfBirth.numberOfLines = 0
        dateOfBirth.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        dateOfBirth.translatesAutoresizingMaskIntoConstraints = false
        
        return dateOfBirth
    }()
    
    
    //MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupSubviews()
        
        setupTeamColorView()
        setupNameLabel()
        setupDividerLine()
        setupNationality()
        setupPosition()
        setupPoints()
        setupWins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    private func setupSubviews() {
        self.addSubview(teamColor)
        self.addSubview(nameLabel)
        self.addSubview(dividerLineView)
        
        nationalityStack.addArrangedSubview(nationalityLabel)
        nationalityStack.addArrangedSubview(nationality)
        self.addSubview(nationalityStack)
        
        positionStack.addArrangedSubview(positionLabel)
        positionStack.addArrangedSubview(position)
        self.addSubview(positionStack)
        
        pointsStack.addArrangedSubview(pointsLabel)
        pointsStack.addArrangedSubview(points)
        self.addSubview(pointsStack)
        
        winsStack.addArrangedSubview(winsLabel)
        winsStack.addArrangedSubview(wins)
        self.addSubview(winsStack)
    }
    
    private func setupTeamColorView() {
        NSLayoutConstraint.activate([
            teamColor.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            teamColor.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Self.HORIZONTAL_PADDING),
            teamColor.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            teamColor.widthAnchor.constraint(equalToConstant: Self.TEAM_COLOR_WIDTH)
        ])
    }
    
    private func setupNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            nameLabel.leftAnchor.constraint(equalTo: teamColor.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Self.TEAM_COLOR_WIDTH)
        ])
    }
    
    private func setupDividerLine() {
        NSLayoutConstraint.activate([
            dividerLineView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            dividerLineView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Self.HORIZONTAL_PADDING),
            dividerLineView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Self.HORIZONTAL_PADDING),
            dividerLineView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }
    
    private func setupNationality() {
        NSLayoutConstraint.activate([
            nationalityStack.topAnchor.constraint(equalTo: dividerLineView.bottomAnchor, constant: 15),
            nationalityStack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Self.HORIZONTAL_PADDING),
            nationalityStack.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Self.HORIZONTAL_PADDING)
        ])
    }
    
    private func setupPosition() {
        NSLayoutConstraint.activate([
            positionStack.topAnchor.constraint(equalTo: nationalityStack.bottomAnchor, constant: 10),
            positionStack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Self.HORIZONTAL_PADDING),
            positionStack.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Self.HORIZONTAL_PADDING)
        ])
    }
    
    private func setupPoints() {
        NSLayoutConstraint.activate([
            pointsStack.topAnchor.constraint(equalTo: positionStack.bottomAnchor, constant: 10),
            pointsStack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Self.HORIZONTAL_PADDING),
            pointsStack.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Self.HORIZONTAL_PADDING)
        ])
    }
    
    private func setupWins() {
        NSLayoutConstraint.activate([
            winsStack.topAnchor.constraint(equalTo: pointsStack.bottomAnchor, constant: 10),
            winsStack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Self.HORIZONTAL_PADDING),
            winsStack.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Self.HORIZONTAL_PADDING)
        ])
    }
}
