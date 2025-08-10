//
//  ProfileSettingViewController.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/11/25.
//

import UIKit
import SnapKit

class ProfileSettingViewController: UIViewController {

    let profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.tintColor = .black
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.layer.borderColor = UIColor.customBlue.cgColor
        button.layer.borderWidth = 5
        button.clipsToBounds = true

        return button
    }()

    let profileCameraImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "camera.circle.fill"))
        image.tintColor = .customBlue
        image.clipsToBounds = true

        return image
    }()

    let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요 :)"
        textField.font = .systemFont(ofSize: 15)

        return textField
    }()

    let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray

        return view
    }()

    let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)

		return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureNavigation()
        configureHierachy()
        configureLayout()
        configureView()
    }

    func configureTabBar() {
        tabBarController?.isTabBarHidden = true
    }

    func configureNavigation() {
        navigationItem.title = "PROFILE SETTING"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.left"), target: self, action: #selector(navigationBackButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc func navigationBackButtonTapped() {
        tabBarController?.isTabBarHidden = false
        navigationController?.popViewController(animated: true)
    }

    func configureHierachy() {
        view.addSubview(profileButton)
        view.addSubview(profileCameraImage)

        view.addSubview(nickNameTextField)
        view.addSubview(underLine)
        view.addSubview(resultLabel)
    }

    func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(88)
        }
        //TODO: 이미지 잘림, profileButton안에 넣으면 cliptoBounds로 잘림, 밖에두면 선이 겹침, 해결필요
        profileCameraImage.snp.makeConstraints { make in
            make.bottom.equalTo(profileButton.snp.bottom)
            make.trailing.equalTo(profileButton.snp.trailing)
            make.size.equalTo(32)
        }

        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        underLine.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(1)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

    }

    func configureView() {
        DispatchQueue.main.async {
            self.profileButton.layer.cornerRadius = self.profileButton.bounds.width / 2
        }

        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        nickNameTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }

    @objc func profileButtonTapped() {
	//TODO: 프로필 이미지 세팅 뷰로 넘어가기
        print("클릭됨")
    }

    //TODO: do catch
    @objc func didChangeTextField(_ textField: UITextField) {
        guard let nickname = textField.text else {
            resultLabel.text = ""
            return
        }

        guard nickname.count > 1 && nickname.count < 10 else {
            resultLabel.text = "닉네임은 2글자 이상, 10글자 미만으로 입력해주세요"
            resultLabel.textColor = .red
            return
        }

        let spacialSignRegex = "^[^#$@%]+$"
        guard (nickname.range(of: spacialSignRegex, options: .regularExpression) != nil) else {
            resultLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            resultLabel.textColor = .red
            return
        }

        let numberRegex = "^[^0-9]+$"
        guard (nickname.range(of: numberRegex, options: .regularExpression) != nil) else {
            resultLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            resultLabel.textColor = .red
            return
        }

        resultLabel.text = "사용할 수 있는 닉네임이에요"
        resultLabel.textColor = .blue
    }
}
