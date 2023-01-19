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
        return UITableViewCell()
//        let scheduleCell = ScheduleCell(style: .default, reuseIdentifier: ScheduleCell.CELL_ID)
//        let race: Race? = currentSchedule == .upcoming ? viewModel.upcomingRaces?[indexPath.section] : viewModel.pastRaces?[indexPath.section]
//
//
//        if let race = race {
//            scheduleCell.roundLabel.text = "Round \(String(race.round))"
//
//            if let date = race.date {
//                let raceDateFormatter = DateFormatter()
//                raceDateFormatter.dateFormat = "MM/dd/yyyy"
//                let raceDate = raceDateFormatter.string(from: date)
//
//                scheduleCell.raceDateLabel.text = raceDate
//            }
//
//            scheduleCell.grandPrixNameLabel.text = race.raceName
//            scheduleCell.locationLabel.text = "\(race.circuit!.location!.locality!), \(race.circuit!.location!.country!)"
//
//        }
//
//        return scheduleCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch currentStandings {
        case .drivers:
            //return viewModel.upcomingRaces?.count ?? 0
            return 0
        case .constructors:
            //return viewModel.pastRaces?.count ?? 0
            return 0
        }
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
        //let cell = tableView.cellForRow(at: indexPath)! as! ScheduleCell
        
        
    }
}


//MARK: - DataChangeDelegate Conformance

extension StandingsVC: DataChangeDelegate {
    func didUpdate(with state: State) {
        switch state {
        case .success:
            print("In success state")
            
            tableView.reloadData()
            
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
