//
//  RaceDetailViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/25/23.
//

import Foundation
import CoreLocation



class RaceDetailViewModel {
    
    var myTimeItems: [RaceWeekendEvent] = []
    var trackTimeItems: [RaceWeekendEvent] = []
    var delegate: DataChangeDelegate?
    let race: Race
    
    init(race: Race) {
        self.race = race
    }
    
    private func calculateEventTimes(timezone: TimeZone, forTime: Time) {
        
        if let date = race.date, let weekendEvent = createWeekendEventItem(time: forTime, event: .race, timezone: timezone, date: date) {
            if forTime == .deviceLocal {
                myTimeItems.append(weekendEvent)
            } else {
                trackTimeItems.append(weekendEvent)
            }
        }
        
        if let date = race.sprint?.date, let weekendEvent = createWeekendEventItem(time: forTime, event: .sprint, timezone: timezone, date: date) {
            if forTime == .deviceLocal {
                myTimeItems.append(weekendEvent)
            } else {
                trackTimeItems.append(weekendEvent)
            }
        }
        
        if let date = race.qualifying?.date, let weekendEvent = createWeekendEventItem(time: forTime, event: .qualifying, timezone: timezone, date: date) {
            if forTime == .deviceLocal {
                myTimeItems.append(weekendEvent)
            } else {
                trackTimeItems.append(weekendEvent)
            }
        }
        
        if let date = race.thirdPractice?.date, let weekendEvent = createWeekendEventItem(time: forTime, event: .practice3, timezone: timezone, date: date) {
            if forTime == .deviceLocal {
                myTimeItems.append(weekendEvent)
            } else {
                trackTimeItems.append(weekendEvent)
            }
        }
        
        if let date = race.secondPractice?.date, let weekendEvent = createWeekendEventItem(time: forTime, event: .practice2, timezone: timezone, date: date) {
            if forTime == .deviceLocal {
                myTimeItems.append(weekendEvent)
            } else {
                trackTimeItems.append(weekendEvent)
            }
        }
        
        if let date = race.firstPractice?.date, let weekendEvent = createWeekendEventItem(time: forTime, event: .practice1, timezone: timezone, date: date) {
            if forTime == .deviceLocal {
                myTimeItems.append(weekendEvent)
            } else {
                trackTimeItems.append(weekendEvent)
            }
        }
    }
    
    private func createWeekendEventItem(time: Time, event: WeekendEventItem, timezone: TimeZone, date: Date) -> RaceWeekendEvent? {
        
        let localComponents = time == .deviceLocal ? date.getDeviceLocalTimeDateComponents() : date.getSpecifiedTimezoneDateComponents(timezone: timezone)
        
        if let day = localComponents.day, let month = localComponents.month {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = timezone
            let time = formatter.string(from: date)
            
            let event = RaceWeekendEvent(day: String(day), month: String(DateFormatter().monthSymbols[month - 1]), title: event.rawValue, time: time)
            
            return event
        }
        
        return nil
    }
    
    
}


//MARK: - RaceDetailViewModelDelegate methods

extension RaceDetailViewModel: RaceDetailViewModelDelegate {
    func calculateLocalAndTrackLocalTimes() {
        
        calculateEventTimes(timezone: .current, forTime: .deviceLocal)
        
        
        guard let latitude = race.circuit?.location?.latitude, let longitude = race.circuit?.location?.longitude else {
            self.delegate?.didUpdate(with: .error(GeocodeError.noLocation))
            return
        }

        let location = CLLocation.init(latitude: latitude, longitude: longitude)

        let geoCoder = CLGeocoder();

        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in

            if let error = error {
                self?.delegate?.didUpdate(with: .error(error))
                return
            }

            if let timeZone = placemarks?.last?.timeZone {
        
                self?.calculateEventTimes(timezone: timeZone, forTime: .trackLocal)
            } else {
                self?.delegate?.didUpdate(with: .error(GeocodeError.noLocation))
            }


            self?.delegate?.didUpdate(with: .success)
        }

        
        
    }
}


//MARK: - RaceWeekendEvent helper class
class RaceWeekendEvent {
    let day: String
    let month: String
    let title: String
    let time: String
    
    init(day: String, month: String, title: String, time: String) {
        self.day = day
        self.month = month
        self.title = title
        self.time = time
    }
}


//MARK: - Date extension for calculating local date components

extension Date {
    func getDeviceLocalTimeDateComponents() -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
    
    func getSpecifiedTimezoneDateComponents(timezone: TimeZone) -> DateComponents {
        var calendar = Calendar.current
        
        calendar.timeZone = timezone
        
        return calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
}
