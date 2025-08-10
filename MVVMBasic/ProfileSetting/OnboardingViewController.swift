//
//  OnboardingViewController.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/11/25.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierachy()
        configureLayout()
        configureView()
    }

    func configureHierachy() {
        view.addSubview(startButton)
    }

    func configureLayout() {
        startButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func configureView() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc func startButtonTapped() {
		let nextVC = ProfileSettingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
