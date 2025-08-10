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
    }

    func configureView() {
        DispatchQueue.main.async {
            self.profileButton.layer.cornerRadius = self.profileButton.bounds.width / 2
        }

        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }

    @objc func profileButtonTapped() {
	//TODO: 프로필 이미지 세팅 뷰로 넘어가기
        print("클릭됨")
    }
}
