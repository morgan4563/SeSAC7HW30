//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

final class CurrencyViewModel {

    var convertButtonTapped = Observable(())
    var inputText = Observable("")
    var outputText = Observable("")

    init() {
        convertButtonTapped.bind { _ in
            self.convertCurrency()
        }
    }

    private func convertCurrency() {
        guard let amount = Double(inputText.value) else {
            outputText.value = "올바른 금액을 입력해주세요"
            return
        }

        let exchangeRate = 1350.0

        let convertedAmount = amount / exchangeRate
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
