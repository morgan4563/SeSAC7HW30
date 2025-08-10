//
//  WordCountViewModel.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/10/25.
//

import Foundation

class WordCountViewModel {
    var outputChanged: (() -> Void)?

    var inputText = "" {
        didSet {
            print("inputText")
			makeOutputText()
        }
    }

    var outputText = "현재까지 0글자 작성중" {
        didSet {
            print("outputText")
            outputChanged?()
        }
    }

    private func makeOutputText() {
        outputText = "현재까지 \(inputText.count)글자 작성중"
    }
}
