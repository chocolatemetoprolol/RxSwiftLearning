//
//  ViewController.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/3/31.
//  Copyright © 2021 WR. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

     weak var usernameTextField: WYTextField!
     weak var passwordTextField: WYTextField!
     weak var loginBtn: WYButton!

     fileprivate lazy var bag : DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(backgroundLayer())
        setUp()
        setupInputView()
        // Do any additional setup after loading the view.
    }

    func setUp() -> Void {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 50))
        titleLabel.center = CGPoint(x: view.center.x, y: 150)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "RxSwiftLearning"
        titleLabel.font = UIFont.systemFont(ofSize: 40.0)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)

        let username = WYTextField(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        username.center = CGPoint(x: view.center.x, y: 350)
        username.placeholder = "邮箱"
        username.tag = 0
        username.accessibilityIdentifier = "Email"
        view.addSubview(username)
        self.usernameTextField = username
        
        let password = WYTextField(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        password.center = CGPoint(x: view.center.x, y: username.center.y + 60)
        password.placeholder = "密码"
        password.tag = 1
        password.accessibilityIdentifier = "Password"
        view.addSubview(password)
        self.passwordTextField = password

        let login = WYButton(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        login.center = CGPoint(x: view.center.x, y: password.center.y + 100)
        view.addSubview(login)
        self.loginBtn = login

        login.translateBlock = {
           self.view.endEditing(true)
           let tableVc = TableViewController()
           self.navigationController?.pushViewController(tableVc, animated: true)
        }
    }

    func setupInputView() {
        let userObservable = usernameTextField.textField?.rx.text.map({ InputValidator.isValidEmail($0!) })
        userObservable?.map({$0 ? "邮箱" : "输入有效邮箱地址"}).subscribe(onNext: { text in
            self.usernameTextField.placeholder = text
        }).disposed(by: bag)

        let passObservable = passwordTextField.textField?.rx.text.map({ InputValidator.isValidPassword($0!) })
        passObservable?.map({$0 ? "密码" : "密码不能少于8位"}).subscribe(onNext: { text in
            self.passwordTextField.placeholder = text
        }).disposed(by: bag)

        Observable.combineLatest(userObservable!, passObservable!){(varildUser,varildPass) -> Bool in
            return varildPass && varildUser
        }.subscribe (onNext:{ (isEnable) in
            self.loginBtn.button?.isEnabled = isEnable
        }).disposed(by: bag)
    }

    func backgroundLayer() -> CALayer! {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        let lcolor =  UIColor.purple
        let gcolor = UIColor.blue
        gradientLayer.colors = [lcolor.cgColor, gcolor.cgColor].compactMap { $0 }
        gradientLayer.colors = [lcolor.cgColor, gcolor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [NSNumber(value: 0.5), NSNumber(value: 1)]
        return gradientLayer
    }
}

