//
//  ConstructorDetailVC.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/23/23.
//

import UIKit

class ConstructorDetailVC: UIViewController {

    //MARK: - Variables
    
    let constructorDetailView: ConstructorDetailView
    let constructor: ConstructorStandingItem
    
    
    //MARK: - Initializers
    
    init(withConstructor constructor: ConstructorStandingItem) {
        self.constructorDetailView = ConstructorDetailView()
        self.constructor = constructor
        
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
        self.view = constructorDetailView
    }
    
    
    //MARK: - Functions
    
    private func setViewValues() {
        guard let constructorInfo = self.constructor.constructor else { return }
        
        if let name = constructorInfo.name {
            setName(name: name)
        }
        
        if let id = constructorInfo.id {
            setTeamColor(constructorId: id)
        }
        
        if let nationality = constructorInfo.nationality {
            setNationality(nationality: nationality)
        }
        
        setPosition(position: Int(truncatingIfNeeded: self.constructor.position))
        setPoints(points: Int(truncatingIfNeeded: self.constructor.points))
                  setWins(wins: Int(truncatingIfNeeded: self.constructor.wins))
    }
    
    private func setName(name: String) {
        constructorDetailView.nameLabel.text = name
        
        constructorDetailView.nameLabel.isHidden = false
    }

    private func setTeamColor(constructorId: String) {
        constructorDetailView.teamColor.backgroundColor = Constants.Colors.teamColors[constructorId]
    }
    
    private func setNationality(nationality: String) {
        constructorDetailView.nationality.text = nationality
        
        constructorDetailView.nationalityStack.isHidden = false
    }
    
    private func setPosition(position: Int) {
        constructorDetailView.position.text = String(position)
        
        constructorDetailView.positionStack.isHidden = false
    }
    
    private func setPoints(points: Int) {
        constructorDetailView.points.text = String(points)
        
        constructorDetailView.pointsStack.isHidden = false
    }
    
    private func setWins(wins: Int) {
        constructorDetailView.wins.text = String(wins)
        
        constructorDetailView.winsStack.isHidden = false
    }
}
