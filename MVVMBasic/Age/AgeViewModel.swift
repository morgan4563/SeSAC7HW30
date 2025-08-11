//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

final class AgeViewModel {
	var inputText = Observable("")
    var outputText = Observable("")
	var outputIsValid = Observable(false)

    init() {
        inputText.bind { _ in
            self.inputChanged()
        }
    }

    private func inputChanged() {
        do {
            try isVaildAge(inputText.value)
            outputText.value = "적절한 입력값입니다"
            outputIsValid.value = true

        } catch {
            switch error {
            case .emptyString:
                outputText.value = "입력값이 없습니다"
                break
            case .isNotNumber:
                outputText.value = "입력값이 숫자가 아닙니다"
                break
            case .oneHundredOver:
                outputText.value = "입력값이 100 초과입니다"
                break
            case .oneUnder:
                outputText.value = "입력값이 1 미만입니다"
                break
            }
            outputIsValid.value = false
        }
    }

    private func isVaildAge(_ text: String) throws(AgeError) {

        guard !text.isEmpty else {
            throw AgeError.emptyString
        }
        guard let ageInt = Int(text) else {
            throw AgeError.isNotNumber
        }
        guard ageInt <= 100 else {
            throw AgeError.oneHundredOver
        }
        guard ageInt >= 1 else {
            throw AgeError.oneUnder
        }
    }
}
