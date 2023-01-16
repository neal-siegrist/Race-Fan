//
//  NetworkingError.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//

import Foundation

enum NetworkingError: Error {
    case parsingError
    case responseError(Error)
    case noData
}
