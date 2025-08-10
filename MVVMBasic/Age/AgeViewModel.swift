//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

final class AgeViewModel {
    var outputChanged: (() -> Void)?

    var inputText = "" {
        didSet {
            print("inputText")
            inputChanged()
        }
    }
    
    var outputText = "" {
        didSet {
            print("outputChanged")
            outputChanged?()
        }
    }

    var outputIsValid = false

    func inputChanged() {
        do {
            try isVaildAge(inputText)
            outputIsValid = true
            outputText = "적절한 입력값입니다"
        } catch {
            outputIsValid = false
            switch error {
            case .emptyString:
                outputText = "입력값이 없습니다"
            case .isNotNumber:
                outputText = "입력값이 숫자가 아닙니다"
            case .oneHundredOver:
                outputText = "입력값이 100 초과입니다"
            case .oneUnder:
                outputText = "입력값이 1 미만입니다"
            }
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
