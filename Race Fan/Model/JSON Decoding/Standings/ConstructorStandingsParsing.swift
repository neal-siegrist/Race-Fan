//
//  ConstructorStandings.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/20/23.
//

import Foundation

struct ConstructorStandingsParsing: Codable {
    let MRData: ConstructorStandingsTable
}

struct ConstructorStandingsTable: Codable {
    let StandingsTable: ConstructorStandingsLists
}

struct ConstructorStandingsLists: Codable {
    let StandingsLists: [ConstructorStandings]
}
