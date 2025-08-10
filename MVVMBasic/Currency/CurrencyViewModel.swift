//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

class CurrencyViewModel {
    var outputChanged: (() -> Void)?

    var inputText = "" {
        didSet {
            print("convertButtonTapped")
            convertCurrency()
        }
    }

    var outputText = "" {
        didSet {
            print("outputText")
            outputChanged?()
        }
    }

    private func convertCurrency() {
        guard let amount = Double(inputText) else {
            outputText = "올바른 금액을 입력해주세요"
            return
        }

        let exchangeRate = 1350.0

        let convertedAmount = amount / exchangeRate
        outputText = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
