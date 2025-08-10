//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

class BMIViewController: UIViewController {
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
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
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
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

        guard let height = heightTextField.text else {
            print("키 텍스트필드 nil")
            return
        }

        guard let weight = weightTextField.text else {
            print("몸무게 텍스트필드 nil")
            return
        }

        let maxValue = 200
        let minValue = 30

        do {
            let doubleTypeHeight = try isVaildValue(height ,maxValue: maxValue, minValue: minValue)
            let doubleTypeWeight = try isVaildValue(weight, maxValue: maxValue, minValue: minValue)

            let bmi = calcBMI(weight: doubleTypeWeight, height: doubleTypeHeight * 0.01)
            messageHandling(message: bmi, result: true)
        } catch {
            switch error {
            case .emptyString:
                messageHandling(message: "입력값이 없습니다")
            case .isNotNumber:
                messageHandling(message: "입력값이 숫자가 아닙니다")
            case .maxValueOver:
                messageHandling(message: "입력값이 \(maxValue) 초과입니다")
            case .minValueUnder:
                messageHandling(message: "입력값이 \(minValue) 미만입니다")
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

    private func messageHandling(message: String, result: Bool = false) {
        if !result {
            showAlert(message: message)
        }
        resultLabel.text = message
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        
        resetTextField(heightTextField)
        resetTextField(weightTextField)
        present(alert, animated: true)
    }

    private func resetTextField(_ textField: UITextField) {
        textField.text = ""
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
