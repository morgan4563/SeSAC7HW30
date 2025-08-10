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

    //TODO: outputChagned 중복호출 방지 처리 필요
    var outputText = "" {
        didSet {
            print("outputChanged")
            outputChanged?()
        }
    }

    var outputIsValid = false {
        didSet {
            print("outputIsValid")
            outputChanged?()
        }
    }

    func inputChanged() {
        do {
            try isVaildAge(inputText)
            outputText = "적절한 입력값입니다"
            outputIsValid = true
        } catch {
            switch error {
            case .emptyString:
                outputText = "입력값이 없습니다"
                outputIsValid = false
            case .isNotNumber:
                outputText = "입력값이 숫자가 아닙니다"
                outputIsValid = false
            case .oneHundredOver:
                outputText = "입력값이 100 초과입니다"
                outputIsValid = false
            case .oneUnder:
                outputText = "입력값이 1 미만입니다"
                outputIsValid = false
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
