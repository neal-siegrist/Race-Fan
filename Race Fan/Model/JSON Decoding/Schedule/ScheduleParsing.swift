//
//  JSONTopLevelKey.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//

import Foundation

struct ScheduleParsing: Codable {
    let MRData: RaceTable
}

struct RaceTable: Codable {
    let RaceTable: Races
}

struct Races: Codable {
    let Races: [Race]
}
