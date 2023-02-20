//
//  DriverDetailVC.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/23/23.
//

import UIKit

class DriverDetailVC: UIViewController {

    //MARK: - Variables
    
    let driverDetailView: DriverDetailView
    let driver: DriverStandingItem
    
    
    //MARK: - Initializers
    
    init(withDriver driver: DriverStandingItem) {
        self.driverDetailView = DriverDetailView()
        self.driver = driver
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewValues()
    }

    override func loadView() {
        self.view = driverDetailView
    }
    
    
    //MARK: - Functions
    
    private func setViewValues() {
        guard let driverInfo = self.driver.driver else { return }
        
        if let constructor = (self.driver.constructors?.allObjects as? [Constructor])?.first, let id = constructor.id, let name = constructor.name {
            
            setTeamColor(constructorId: id)
            setDriverConstructor(constructor: name)
        } else {
            if let driverID = driver.driver?.id, let teamName = Constants.Colors.driverTeams[driverID], let printableConstructorName = Constants.Colors.driverPrintableTeams[driverID] {
                driverDetailView.teamColor.backgroundColor = Constants.Colors.teamColors[teamName]
                setDriverConstructor(constructor: printableConstructorName)
            }
        }
        
        if let firstName = driverInfo.givenName, let lastName = driverInfo.familyName {
            setName(name: "\(firstName) \(lastName)")
        }
        
        if let dateOfBirth = driverInfo.dateOfBirth {
            setDateOfBirth(date: dateOfBirth)
        }
        
        if let nationality = driverInfo.nationality {
            setNationality(nationality: nationality)
        }
        
        setPosition(position: Int(truncatingIfNeeded: driver.position))
        setPoints(points: Int(truncatingIfNeeded: driver.points))
        setWins(wins: Int(truncatingIfNeeded: driver.wins))
    }
    
    private func setName(name: String) {
        driverDetailView.nameLabel.text = name
        
        driverDetailView.nameLabel.isHidden = false
    }
    
    private func setTeamColor(constructorId: String) {
        driverDetailView.teamColor.backgroundColor = Constants.Colors.teamColors[constructorId]
    }
    
    private func setDriverConstructor(constructor: String) {
        driverDetailView.constructorLabel.text = constructor
        driverDetailView.constructorLabel.isHidden = false
    }
    
    private func setDateOfBirth(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        driverDetailView.dateOfBirth.text = dateFormatter.string(from: date)
        driverDetailView.dateOfBirthStack.isHidden = false
    }
    
    private func setNationality(nationality: String) {
        driverDetailView.nationality.text = nationality
        
        driverDetailView.nationalityStack.isHidden = false
    }
    
    private func setPosition(position: Int) {
        driverDetailView.position.text = String(position)
        
        driverDetailView.positionStack.isHidden = false
    }
    
    private func setPoints(points: Int) {
        driverDetailView.points.text = String(points)
        
        driverDetailView.pointsStack.isHidden = false
    }
    
    private func setWins(wins: Int) {
        driverDetailView.wins.text = String(wins)
        
        driverDetailView.winsStack.isHidden = false
    }
}
