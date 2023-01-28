//
//  RaceDetailVC.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/24/23.
//

import UIKit
import MapKit

class RaceDetailVC: UIViewController {

    //MARK: - Variables
    
    let viewModel: RaceDetailViewModel
    let raceDetailView: RaceDetailView
    var currentTimeSelection: TimeSelection = .deviceLocalTime
    
    //MARK: - Initializers
    
    init(race: Race) {
        self.viewModel = RaceDetailViewModel(race: race)
        self.raceDetailView = RaceDetailView()
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Race"
        viewModel.calculateLocalAndTrackLocalTimes()
        viewModel.delegate = self
        
        setupSegmentedControl()
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = raceDetailView
        
        raceDetailView.weekendScheduleTableView.register(WeekendScheduleCell.self, forCellReuseIdentifier: WeekendScheduleCell.CELL_IDENTIFIER)
        
        raceDetailView.weekendScheduleTableView.delegate = self
        raceDetailView.weekendScheduleTableView.dataSource = self
        
        startCountdownTimer()
        setValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    //MARK: - Functions
    
    private func setupMapView() {
        guard let latitude = viewModel.race.circuit?.location?.latitude else { return }
        guard let longitude = viewModel.race.circuit?.location?.longitude else { return }
        
        let mapView = raceDetailView.mapView
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        mapView.region = MKCoordinateRegion(center: coordinate , span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        mapView.addAnnotation(annotation)
        
        mapView.isHidden = false
    }
    
    private func setupSegmentedControl() {
        raceDetailView.timeSegmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
    }
    
    @objc private func segmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            currentTimeSelection = .deviceLocalTime
            self.raceDetailView.weekendScheduleTableView.reloadData()
        case 1:
            currentTimeSelection = .trackLocalTime
            self.raceDetailView.weekendScheduleTableView.reloadData()
        default:
            break
        }
    }
    
    func startCountdownTimer() {
        let secondsUntilNextRace = self.viewModel.race.getSecondsUntilNextRace()
        
        if secondsUntilNextRace > 0 {
            raceDetailView.countdownTimer.startTimer(withSecondsRemaining: secondsUntilNextRace)
            raceDetailView.countdownTimer.isHidden = false
        } else {
            raceDetailView.countdownTimer.isHidden = true
        }
    }
    
    private func setValues() {
        
        if let raceName = self.viewModel.race.raceName {
            setRaceTitle(title: raceName)
        }
        
        if let locality = self.viewModel.race.circuit?.location?.locality, let country = self.viewModel.race.circuit?.location?.country {
            setLocation(location: "\(locality), \(country)")
        }
        
        if let circuitName = self.viewModel.race.circuit?.circuitName {
            setCircuitName(circuitName: circuitName)
        }
    }
    
    private func setRaceTitle(title: String) {
        raceDetailView.raceTitle.text = title
        raceDetailView.raceTitle.isHidden = false
    }
    
    private func setLocation(location: String) {
        raceDetailView.location.text = location
        
        raceDetailView.locationStack.isHidden = false
    }
    
    private func setCircuitName(circuitName: String) {
        raceDetailView.circuitName.text = circuitName
        
        raceDetailView.circuitName.isHidden = false
    }
    
    private func updateUI() {
        raceDetailView.weekendScheduleTableView.reloadData()
    }
}


//MARK: - Table View Delegates

extension RaceDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currentTimeSelection == .deviceLocalTime ? viewModel.localTimeItems.count : viewModel.trackTimeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekendScheduleCell.CELL_IDENTIFIER) as? WeekendScheduleCell else { fatalError("Error created WeekendScheduleCell") }
        
        let weekendEvent = currentTimeSelection == .deviceLocalTime ? viewModel.localTimeItems[indexPath.section] : viewModel.trackTimeItems[indexPath.section]
        
        cell.day.text = weekendEvent.day
        cell.month.text = weekendEvent.month
        cell.eventTitle.text = weekendEvent.title
        cell.eventStartTime.text = weekendEvent.time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}


//MARK: - Data change delegate
extension RaceDetailVC: DataChangeDelegate {
    func didUpdate(with state: State) {
        switch state {
            case .success:
                print("Success")
                self.updateUI()
            case .loading:
                print("Loading")
            case .idle:
                print("Idle")
            case .error(let error):
                print("Error: \(error)")
                self.updateUI()
        }
    }
    
    
}
