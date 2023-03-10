//
//  ViewController2.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/5/23.
//

import UIKit

class ScheduleVC: UIViewController {

    //MARK: - Variables
    
    let scheduleView: ToggleListView
    let tableView: UITableView
    let viewModel: ScheduleViewModel
    var currentSchedule: DisplayedSchedule = .upcoming
    
    
    //MARK: - Initializers
    
    init() {
        self.viewModel = ScheduleViewModel()
        self.scheduleView = ToggleListView()
        self.tableView = self.scheduleView.tableView
        
        super.init(nibName: nil, bundle: nil)
        
        setupSegmentedControl()
        
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.CELL_ID)
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scheduleView.setErrorMessage("Check back for schedule!")
    }
    
    override func loadView() {
        super.loadView()
        
        setupNavigationController()
        
        self.view = scheduleView
    }
    
    
    //MARK: - Functions
    
    private func setupSegmentedControl() {
        scheduleView.segmentedControl.insertSegment(withTitle: "Upcoming", at: 0, animated: false)
        scheduleView.segmentedControl.insertSegment(withTitle: "Past", at: 1, animated: false)
        scheduleView.segmentedControl.selectedSegmentIndex = 0
        
        scheduleView.segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
    }

    private func setupNavigationController() {
        
        navigationItem.title = "Schedule"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
        
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: nil, message: "Error retrieving schedule data. Please try again.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            
            self?.present(alertController, animated: true)
        }
    }
    
    private func startLoading() {
        let loadingWheel = scheduleView.loadingWheel
        
        DispatchQueue.main.async {
            loadingWheel.startAnimating()
            loadingWheel.isHidden = false
        }
    }
    
    private func stopLoading() {
        let loadingWheel = scheduleView.loadingWheel
        
        DispatchQueue.main.async {
            loadingWheel.stopAnimating()
            loadingWheel.isHidden = true
        }
    }
}


//MARK: - Table view delegate and data source

extension ScheduleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let scheduleCell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.CELL_ID) as? ScheduleCell else { fatalError("Cannot deque cell") }
        
        let race: Race? = currentSchedule == .upcoming ? viewModel.upcomingRaces?[indexPath.section] : viewModel.pastRaces?[indexPath.section]
        
        
        if let race = race {
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
        
        return scheduleCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let raceCount = currentSchedule == .upcoming ? viewModel.upcomingRaces?.count ?? 0 : viewModel.pastRaces?.count ?? 0
        
        scheduleView.shouldHideTableView(shouldHide: !(raceCount > 0))
        
        return raceCount
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
        
        let race = currentSchedule == .upcoming ? viewModel.upcomingRaces?[selectedRow] : viewModel.pastRaces?[selectedRow]
        
        if let validRace = race {
            let raceDetailVC = RaceDetailVC(race: validRace)
            self.navigationController?.pushViewController(raceDetailVC, animated: true)
        }
    }
}


//MARK: - DataChangeDelegate Conformance

extension ScheduleVC: DataChangeDelegate {
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
            displayErrorAlert()
        case .loading:
            startLoading()
        }
    }
}
