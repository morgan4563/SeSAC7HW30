//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

final class BirthDayViewModel {

    var resultButtonTapped = Observable(0)
    var inputYearText = Observable("")
    var inputMonthText = Observable("")
    var inputDayText = Observable("")
    var isValidValue = Observable(false)
    var outputText = Observable("")

    init() {
        resultButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            self.makeOutputText()
        }
    }

    private func makeOutputText() {
        do {
            try checkDateInput(inputYearText.value ,maxValue: 2025, minValue: 1)
        } catch {
            switch error {
            case .emptyString:
                outputText.value = "년도 입력값이 없습니다"
                isValidValue.value = false
                return
            case .isNotNumber:
                outputText.value = "년도 입력값이 숫자가 아닙니다"
                isValidValue.value = false
                return
            case .unvalidYear:
                outputText.value = "유효한 년도가 아닙니다"
                isValidValue.value = false
                return
            default:
                return
            }
        }

        do {
            try checkDateInput(inputMonthText.value, maxValue: 12, minValue: 1)
        } catch {
            switch error {
            case .emptyString:
                outputText.value = "월 입력값이 없습니다"
                isValidValue.value = false
                return
            case .isNotNumber:
                outputText.value = "월 입력값이 숫자가 아닙니다"
                isValidValue.value = false
                return
            case .unvalidMonth:
                outputText.value = "유효한 달이 아닙니다"
                isValidValue.value = false
                return
            default:
                return
            }
        }

        do {
            try checkDateInput(inputDayText.value, maxValue: 31, minValue: 1)
        } catch {
            switch error {
            case .emptyString:
                outputText.value = "일 입력값이 없습니다"
                isValidValue.value = false
                return
            case .isNotNumber:
                outputText.value = "일 입력값이 숫자가 아닙니다"
                isValidValue.value = false
                return
            case .unvalidDay:
                outputText.value = "유효한 일이 아닙니다"
                isValidValue.value = false
                return
            default:
                return
            }
        }

        do {
            print("dd")
            let dateString = "\(inputYearText.value)-\(inputMonthText.value)-\(inputDayText.value)"
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            guard let inputDate = df.date(from: dateString) else {
                throw BirthDayError.notDate
            }
            let today = Date()
            guard let dDay = Calendar.current.dateComponents([.day], from: today, to: inputDate).day else { return }
            outputText.value = dDay == 0 ? "DDay" : "D\( dDay > 0 ? "+" : "")\(dDay)"
            isValidValue.value = true
        } catch {
            if error as? BirthDayError == BirthDayError.notDate {
                outputText.value = "Date 형식이 아닙니다"
                isValidValue.value = false
            }
        }
    }

    private func checkDateInput(_ text: String, maxValue: Int, minValue: Int) throws(BirthDayError) {

        guard !text.isEmpty else {
            isValidValue.value = false
            throw .emptyString
        }
        guard let value = Int(text) else {
            isValidValue.value = false
            throw .isNotNumber
        }
        guard value <= maxValue && value >= minValue else {
            isValidValue.value = false
            if text == inputYearText.value {
                throw .unvalidYear
            } else if text == inputMonthText.value {
                throw .unvalidMonth
            } else {
                throw .unvalidDay
            }
        }
        isValidValue.value = true
    }
}
