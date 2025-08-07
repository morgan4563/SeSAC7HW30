//
//  BMIError.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/7/25.
//

import UIKit

enum BMIError: Error {
    case emptyString
    case isNotNumber
	case maxValueOver
    case minValueUnder
}
