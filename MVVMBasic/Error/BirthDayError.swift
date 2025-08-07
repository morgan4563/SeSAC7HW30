//
//  BirthDayError.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/7/25.
//

import UIKit

enum BirthDayError: Error {
    case emptyString
    case isNotNumber
    case unvalidYear
    case unvalidMonth
    case unvalidDay
    case notDate
}
