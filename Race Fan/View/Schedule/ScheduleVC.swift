//
//  ViewController2.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/5/23.
//

import UIKit

class ScheduleVC: UIViewController {

    //MARK: - Variables
    let scheduleView: ScheduleView
    let tableView: UITableView
    let viewModel: ScheduleViewModel
    var currentSchedule: DisplayedSchedule = .upcoming
    
    //MARK: - Initializers
    
    init() {
        self.viewModel = ScheduleViewModel()
        self.scheduleView = ScheduleView()
        self.tableView = self.scheduleView.tableView
        
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
        
        viewModel.fetchSchedule()
    }
    
    override func loadView() {
        super.loadView()
        
        setupNavigationController()
        setupScheduleSegmentedControl()
        
        self.view = scheduleView
    }
    
    
    
    
    //MARK: - Functions

    private func setupNavigationController() {
        
        navigationItem.title = "Schedule"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupScheduleSegmentedControl() {
        scheduleView.scheduleTypeSegmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
    }
    
    @objc private func segmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            currentSchedule = .upcoming
            self.tableView.reloadData()
        case 1:
            currentSchedule = .past
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    func displayErrorAlert() {
        let alertController = UIAlertController(title: nil, message: "Error retrieving schedule data. Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
}


//MARK: - Table view delegate and data source

extension ScheduleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let scheduleCell = ScheduleCell(style: .default, reuseIdentifier: ScheduleCell.CELL_ID)
        
        switch currentSchedule {
            case .upcoming:
                if let schedule = viewModel.upcomingRaces {
                    let race = schedule[indexPath.section]
                    scheduleCell.roundLabel.text = "Round \(String(race.round))"
                    
                    if let date = race.date {
                        let raceDateFormatter = DateFormatter()
                        raceDateFormatter.dateFormat = "MM/dd/yyyy"
                        let raceDate = raceDateFormatter.string(from: date)
                        
                        scheduleCell.raceDateLabel.text = raceDate
                    }
                    
                    scheduleCell.grandPrixNameLabel.text = race.raceName
                    scheduleCell.locationLabel.text = "\(race.circuit!.location!.locality!), \(race.circuit!.location!.country!)"
                }
            case .past:
            if let schedule = viewModel.pastRaces {
                let race = schedule[indexPath.section]
                scheduleCell.roundLabel.text = "Round \(String(race.round))"
                
                if let date = race.date {
                    let raceDateFormatter = DateFormatter()
                    raceDateFormatter.dateFormat = "MM/dd/yyyy"
                    let raceDate = raceDateFormatter.string(from: date)
                    
                    scheduleCell.raceDateLabel.text = raceDate
                }
                
                scheduleCell.grandPrixNameLabel.text = race.raceName
                scheduleCell.locationLabel.text = "\(race.circuit!.location!.locality!), \(race.circuit!.location!.country!)"
            }
        }
        
        return scheduleCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch currentSchedule {
        case .upcoming:
            return viewModel.upcomingRaces?.count ?? 0
        case .past:
            return viewModel.pastRaces?.count ?? 0
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
        let cell = tableView.cellForRow(at: indexPath)! as! ScheduleCell
        
        
    }
}


//MARK: - DataChangeDelegate Conformance

extension ScheduleVC: DataChangeDelegate {
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
