//
//  DataListener.swift
//  Race Fan
//
//  Created by Neal Siegrist on 2/2/23.
//

import Foundation

protocol DataListener {
    func dataIsUpdated(type: ListenerType)
    func errorOccured(error: Error)
}
