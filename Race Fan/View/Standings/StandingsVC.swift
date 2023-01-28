//
//  StandingsVC.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/16/23.
//

import UIKit

class StandingsVC: UIViewController {
    
    //MARK: - Variables
    
    let standingsView: ToggleListView
    let tableView: UITableView
    let viewModel: StandingsViewModel
    var currentStandings: DisplayedStandings = .drivers
    
    //MARK: - Initializers
    
    init() {
        self.viewModel = StandingsViewModel()
        self.standingsView = ToggleListView()
        self.tableView = self.standingsView.tableView
        
        super.init(nibName: nil, bundle: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchStandings()
    }
    
    override func loadView() {
        super.loadView()
        
        setupNavigationController()
        setupSegmentedControl()
        
        self.view = standingsView
    }
    
    
    //MARK: - Functions
    
    private func setupNavigationController() {
        
        navigationItem.title = "Standings"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupSegmentedControl() {
        standingsView.segmentedControl.insertSegment(withTitle: "Drivers", at: 0, animated: false)
        standingsView.segmentedControl.insertSegment(withTitle: "Constructors", at: 1, animated: false)
        standingsView.segmentedControl.selectedSegmentIndex = 0
        
        standingsView.segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
    }
    
    @objc private func segmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            currentStandings = .drivers
            self.tableView.reloadData()
        case 1:
            currentStandings = .constructors
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    func displayErrorAlert() {
        let alertController = UIAlertController(title: nil, message: "Error retrieving standings data. Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
}


//MARK: - Table view delegate and data source

extension StandingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let standingsCell = StandingsCell(style: .default, reuseIdentifier: StandingsCell.CELL_ID)
        
        switch currentStandings {
            case .drivers:
                if let driver = viewModel.driverStandings?[indexPath.section], let driverFirstName = driver.driver?.givenName, let driverLastName = driver.driver?.familyName {
                    standingsCell.positionLabel.text = String(driver.position)
                    standingsCell.nameLabel.text = "\(driverFirstName) \(driverLastName)"
                    standingsCell.pointsLabel.text = "\(String(driver.points)) pts"
                    
                    if let constructor = viewModel.driverStandings?[indexPath.section].constructors?.allObjects as? [Constructor], let id = constructor.first?.id {
                        standingsCell.teamColorView.backgroundColor = Constants.Colors.teamColors[id]
                    }
                }
            case .constructors:
            if let constructor = viewModel.constructorStandings?[indexPath.section], let constructorName = constructor.constructor?.name {
                    standingsCell.positionLabel.text = String(constructor.position)
                    standingsCell.nameLabel.text = constructorName
                    standingsCell.pointsLabel.text = "\(String(constructor.points)) pts"
                    
                if let id = constructor.constructor?.id {
                        standingsCell.teamColorView.backgroundColor = Constants.Colors.teamColors[id]
                    }
                }
        }
        
        return standingsCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let standingsCount = currentStandings == .drivers ? viewModel.driverStandings?.count ?? 0 : viewModel.constructorStandings?.count ?? 0
        
        standingsView.shouldHideTableView(shouldHide: !(standingsCount > 0))
        
        return standingsCount
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRow = indexPath.section
        
        switch currentStandings {
            case .drivers:
                
                //TODO: Maybe handle with error message
                guard let driverStandingItem = viewModel.driverStandings?[selectedRow] else { return }
                
                let driverDetailVC = DriverDetailVC(withDriver: driverStandingItem)
                
                if let sheet = driverDetailVC.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                    sheet.selectedDetentIdentifier = .medium
                    sheet.prefersGrabberVisible = true
                }
                present(driverDetailVC, animated: true, completion: nil)
            
            case .constructors:
                //TODO: Maybe handle with error message
                guard let constructorStandingItem = viewModel.constructorStandings?[selectedRow] else { return }
                
            let constructorDetailVC = ConstructorDetailVC(withConstructor: constructorStandingItem)
                
                if let sheet = constructorDetailVC.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                    sheet.selectedDetentIdentifier = .medium
                    sheet.prefersGrabberVisible = true
                }
                present(constructorDetailVC, animated: true, completion: nil)
        }
    }
}


//MARK: - DataChangeDelegate Conformance

extension StandingsVC: DataChangeDelegate {
    func didUpdate(with state: State) {
        switch state {
        case .success:
            print("In success state")
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            
        case .error(let error):
            print("Error state occured: \(error)")
            
            //Show error message
            displayErrorAlert()
        case .idle:
            print("In idle state")
        case .loading:
            print("In loading state")
            //Show loading wheel?
        }
    }
}
