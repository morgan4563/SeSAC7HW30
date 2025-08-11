//
//  WordCountViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

class WordCountViewModel {
    var inputText = Observable("")

    var outputText = Observable("현재까지 0글자 작성중")

    init() {
        inputText.bind { _ in
            self.makeOutputText()
        }
    }

    private func makeOutputText() {
        outputText.value = "현재까지 \(inputText.value.count)글자 작성중"
    }
}
