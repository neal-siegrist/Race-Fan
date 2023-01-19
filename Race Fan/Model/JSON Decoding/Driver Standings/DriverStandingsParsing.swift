//
//  DriverStandingsParsing.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/19/23.
//

import Foundation

struct DriverStandingsParsing: Codable {
    let MRData: StandingsTable
}

struct StandingsTable: Codable {
    let StandingsTable: StandingsLists
}

struct StandingsLists: Codable {
    let StandingsLists: [DriverStandings]
}
