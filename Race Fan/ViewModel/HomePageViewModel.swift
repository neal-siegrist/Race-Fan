//
//  HomePageViewModel.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/7/23.
//

import Foundation

class HomePageViewModel {
    
    func getSecondsUntilNextRace() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let xmas = formatter.date(from: "2023/12/25 00:00")
        
        let now = Date()
        let diffSeconds = xmas!.timeIntervalSinceReferenceDate - now.timeIntervalSinceReferenceDate
        print(diffSeconds)
        
        print("Days: \(Int(diffSeconds / (60*60*24)))")
        print("Leftover after days: \(diffSeconds.remainder(dividingBy: 60*60*24))")
        
        return Int(diffSeconds)
    }
    
}
