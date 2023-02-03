//
//  TopConstructorStandingsVC.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/28/23.
//

import UIKit

class TopConstructorStandingsVC: UIViewController {

    //MARK: - Variables
    
    let topConstructorStandingsView: TopStandingsView
    let tableView: UITableView
    let viewModel: TopConstructorStandingsViewModel
    
    //MARK: - Initializers
    
    init() {
        self.topConstructorStandingsView = TopStandingsView()
        self.tableView = topConstructorStandingsView.tableView
        self.viewModel = TopConstructorStandingsViewModel()
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = self.topConstructorStandingsView
    }
    

    //MARK: - Functions
    
    private func setupTableView() {
        topConstructorStandingsView.titleLabel.text = "Top Constructor Standings"
        topConstructorStandingsView.setErrorMessage("Check back for constructor standings!")
        
        topConstructorStandingsView.tableView.dataSource = self
        topConstructorStandingsView.tableView.delegate = self
        
        tableView.register(StandingsCell.self, forCellReuseIdentifier: StandingsCell.CELL_ID)
    }
    
    private func startLoading() {
        let loadingWheel = topConstructorStandingsView.loadingWheel
        
        DispatchQueue.main.async {
            loadingWheel.startAnimating()
            loadingWheel.isHidden = false
        }
    }
    
    private func stopLoading() {
        let loadingWheel = topConstructorStandingsView.loadingWheel
        
        DispatchQueue.main.async {
            loadingWheel.stopAnimating()
            loadingWheel.isHidden = true
        }
    }
}


//MARK: - Table view delegate and data source

extension TopConstructorStandingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.constructorStandings?.count ?? 0
        
        topConstructorStandingsView.shouldHideTableView(shouldHide: !(count > 0))
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let dequedCell = tableView.dequeueReusableCell(withIdentifier: StandingsCell.CELL_ID) as? StandingsCell else { fatalError("Cannot deque StandingsCell in TopDriverStandingsViewController") }
        
        let cell = customizeCell(cell: dequedCell)
        
        if let constructor = viewModel.constructorStandings?[indexPath.row], let name = constructor.constructor?.name {
            cell.positionLabel.text = String(constructor.position)
            cell.nameLabel.text = name
            cell.pointsLabel.text = String(constructor.points)
            
            if let id = constructor.constructor?.id {
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

extension TopConstructorStandingsVC: DataChangeDelegate {
    func didUpdate(with state: State) {
        switch state {
        case .success:
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.stopLoading()
            }
        case .error(let error):
            print("Error state occured on TopConstructorStandingsVC: \(error)")
            stopLoading()
        case .loading:
            print("In constructor vc loading state")
            startLoading()
        }
    }
}
