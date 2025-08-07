//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

final class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)

        guard let text = textField.text else {
            print("텍스트 필드 글자 nil")
            return
        }

        do {
            try isVaildAge(text)
            messageHandling(message: "적절한 입력값입니다", result: true)
        } catch {
            switch error {
            case .emptyString:
                messageHandling(message: "입력값이 없습니다")
            case .isNotNumber:
                messageHandling(message: "입력값이 숫자가 아닙니다")
            case .oneHundredOver:
                messageHandling(message: "입력값이 100 초과입니다")
            case .oneUnder:
                messageHandling(message: "입력값이 1 미만입니다")
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

    private func messageHandling(message: String, result: Bool = false) {
        if !result {
            showAlert(message: message)
        }
        label.text = message
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        resetTextField(textField)
        present(alert, animated: true)
    }

    private func resetTextField(_ textField: UITextField) {
        textField.text = ""
    }
}
