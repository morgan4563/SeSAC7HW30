//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

final class BirthDayViewModel {
    var outputChanged: (() -> Void)?

    var resultButtonTapped = 0 {
        didSet {
			makeOutputText()
        }
    }

    var inputYearText = ""
    var inputMonthText = ""
    var inputDayText = ""
    var isValidValue = false

    var outputText = "" {
        didSet {
            print("outputText")
            outputChanged?()
        }
    }

    private func makeOutputText() {
        do {
            try checkDateInput(inputYearText ,maxValue: 2025, minValue: 1)
        } catch {
            switch error {
            case .emptyString:
                outputText = "년도 입력값이 없습니다"
                return
            case .isNotNumber:
                outputText = "년도 입력값이 숫자가 아닙니다"
                return
            case .unvalidYear:
                outputText = "유효한 년도가 아닙니다"
                return
            default:
                return
            }
        }

        do {
            try checkDateInput(inputMonthText, maxValue: 12, minValue: 1)
        } catch {
            switch error {
            case .emptyString:
                outputText = "월 입력값이 없습니다"
                return
            case .isNotNumber:
                outputText = "월 입력값이 숫자가 아닙니다"
                return
            case .unvalidMonth:
                outputText = "유효한 달이 아닙니다"
                return
            default:
                return
            }
        }

        do {
            try checkDateInput(inputDayText, maxValue: 31, minValue: 1)
        } catch {
            switch error {
            case .emptyString:
                outputText = "일 입력값이 없습니다"
                return
            case .isNotNumber:
                outputText = "일 입력값이 숫자가 아닙니다"
                return
            case .unvalidDay:
                outputText = "유효한 일이 아닙니다"
                return
            default:
                return
            }
        }

        do {
            let dateString = "\(inputYearText)-\(inputMonthText)-\(inputDayText)"
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            guard let inputDate = df.date(from: dateString) else {
                throw BirthDayError.notDate
            }
            let today = Date()
            guard let dDay = Calendar.current.dateComponents([.day], from: today, to: inputDate).day else { return }
            outputText = dDay == 0 ? "DDay" : "D\( dDay > 0 ? "+" : "")\(dDay)"
            isValidValue = true
        } catch {
            if error as? BirthDayError == BirthDayError.notDate {
                isValidValue = false
                outputText = "Date 형식이 아닙니다"
            }
        }
    }

    private func checkDateInput(_ text: String, maxValue: Int, minValue: Int) throws(BirthDayError) {

        guard !text.isEmpty else {
            isValidValue = false
            throw .emptyString
        }
        guard let value = Int(text) else {
            isValidValue = false
            throw .isNotNumber
        }
        guard value <= maxValue && value >= minValue else {
            isValidValue = false
            if text == inputYearText {
                throw .unvalidYear
            } else if text == inputMonthText {
                throw .unvalidMonth
            } else {
                throw .unvalidDay
            }
        }
        isValidValue = true
    }
}
