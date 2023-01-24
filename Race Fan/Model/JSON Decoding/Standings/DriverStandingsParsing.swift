//
//  StandingsParsing.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/20/23.
//

import Foundation

struct DriverStandingsParsing: Codable {
    let MRData: DriverStandingsTable
}

struct DriverStandingsTable: Codable {
    let StandingsTable: DriverStandingsLists
}

struct DriverStandingsLists: Codable {
    let StandingsLists: [DriverStandings]
}
