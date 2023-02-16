//
//  TopDriverStandingsViewController.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/28/23.
//

import UIKit

class TopDriverStandingsVC: UIViewController {

    //MARK: - Variables
    
    let topDriverStandingsView: TopStandingsView
    let tableView: UITableView
    let viewModel: TopDriverStandingsViewModel
    
    
    //MARK: - Initializers
    
    init() {
        self.topDriverStandingsView = TopStandingsView()
        self.tableView = topDriverStandingsView.tableView
        self.viewModel = TopDriverStandingsViewModel()
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = self.topDriverStandingsView
    }

    
    //MARK: - Functions
    
    private func setupTableView() {
        topDriverStandingsView.titleLabel.text = "Top Driver Standings"
        topDriverStandingsView.setErrorMessage("Check back for driver standings!")
        
        topDriverStandingsView.tableView.dataSource = self
        topDriverStandingsView.tableView.delegate = self
        
        tableView.register(StandingsCell.self, forCellReuseIdentifier: StandingsCell.CELL_ID)
    }
    
    private func startLoading() {
        let loadingWheel = topDriverStandingsView.loadingWheel
        
        DispatchQueue.main.async {
            loadingWheel.startAnimating()
            loadingWheel.isHidden = false
        }
    }
    
    private func stopLoading() {
        let loadingWheel = topDriverStandingsView.loadingWheel
        
        DispatchQueue.main.async {
            loadingWheel.stopAnimating()
            loadingWheel.isHidden = true
        }
    }
}


//MARK: - Table view delegate and data source

extension TopDriverStandingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.driverStandings?.count ?? 0
        
        topDriverStandingsView.shouldHideTableView(shouldHide: !(count > 0))
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let dequedCell = tableView.dequeueReusableCell(withIdentifier: StandingsCell.CELL_ID) as? StandingsCell else { fatalError("Cannot deque StandingsCell in TopDriverStandingsViewController") }
        
        let cell = customizeCell(cell: dequedCell)
        
        if let driver = viewModel.driverStandings?[indexPath.row], let firstName = driver.driver?.givenName, let lastName = driver.driver?.familyName {
            cell.positionLabel.text = String(driver.position)
            cell.nameLabel.text = "\(firstName) \(lastName)"
            cell.pointsLabel.text = String(driver.points)
            
            if let constructor = viewModel.driverStandings?[indexPath.row].constructors?.allObjects as? [Constructor], let id = constructor.first?.id {
                cell.teamColorView.backgroundColor = Constants.Colors.teamColors[id]
            }
        }
        return cell
    }
    
    private func customizeCell(cell: StandingsCell) -> StandingsCell {
        
        cell.pointsLabel.font = UIFont.systemFont(ofSize: 8, weight: .light)
        cell.nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        cell.pointsLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        return cell
    }
}

extension TopDriverStandingsVC: DataChangeDelegate {
    func didUpdate(with state: State) {
        switch state {
        case .success:
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.stopLoading()
            }
        case .error(_):
            //print("Error state occured: \(error)")
            stopLoading()
        case .loading:
            startLoading()
        }
    }
}
