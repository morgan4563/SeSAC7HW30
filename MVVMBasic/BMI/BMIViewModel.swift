//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

final class BMIViewModel {

    var resultButtonTapped = Observable(0)
    var inputHeightText = Observable("")
    var inputWeightText = Observable("")
    var isValidValue = Observable(true)
    var outputText = Observable("")

    init() {
        resultButtonTapped.bind { _ in
            self.makeOutputText()
        }
    }

    private func makeOutputText() {
        let maxValue = 200
        let minValue = 30

        do {
            let validHeight = try isVaildValue(inputHeightText.value ,maxValue: maxValue, minValue: minValue)
            let validWeight = try isVaildValue(inputWeightText.value, maxValue: maxValue, minValue: minValue)
            let bmi = calcBMI(weight: validWeight, height: validHeight * 0.01)
            outputText.value = bmi
            isValidValue.value = true
        } catch {
            switch error {
            case .emptyString:
                outputText.value = "입력값이 없습니다"
                isValidValue.value = false
            case .isNotNumber:
                outputText.value = "입력값이 숫자가 아닙니다"
                isValidValue.value = false
            case .maxValueOver:
                outputText.value = "입력값이 \(maxValue) 초과입니다"
                isValidValue.value = false
            case .minValueUnder:
                outputText.value = "입력값이 \(minValue) 미만입니다"
                isValidValue.value = false
            }
        }
    }

    private func isVaildValue(_ text: String, maxValue: Int, minValue: Int) throws(BMIError) -> Double {

        guard !text.isEmpty else {
            throw BMIError.emptyString
        }
        guard let value = Int(text) else {
            throw BMIError.isNotNumber
        }
        guard value <= maxValue else {
            throw BMIError.maxValueOver
        }
        guard value >= minValue else {
            throw BMIError.minValueUnder
        }

        return Double(value)
    }

    private func calcBMI(weight: Double, height: Double) -> String {
        let bmi = weight / (height * height)
        var result: String
        if bmi < 18.5 {
            result = "저체중"
        } else if bmi < 24.9 {
            result = "정상체중"
        } else {
            result = "과체중"
        }

        return "BMI: \(String(format: "%.2f", bmi)), \(result) 입니다"
    }
}
