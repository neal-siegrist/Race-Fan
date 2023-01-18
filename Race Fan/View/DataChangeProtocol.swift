//
//  DataChangeDelegate.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/17/23.
//

import Foundation

protocol DataChangeDelegate {
    func didUpdate(with state: State)
}
