//
//  CustomViewController.swift
//  SampleDelegateApp
//
//  Created by sakiyamaK on 2024/07/16.
//

import UIKit

final class CustomViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var customView: CustomView = {
        let customView = CustomView()
        // delegate(任されるインスタンス)はselfですとcustomViewに教えてやる
        customView.delegate = self
        return customView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "ここから下は複雑なレイアウトのため別クラスにしている\nこうすると他のVCでも使いまわせるし便利になるよ"
        label.textAlignment = .center
        label.backgroundColor = .systemGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(stackView)
        
        stackView.applyArroundConstraint(equalTo: self.view.safeAreaLayoutGuide)

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(customView)
    }
}

extension CustomViewController: CustomViewDelegate {
    func tapButton() {
        print("delegateのtapButtonが呼ばれた")
    }
    
    func closeKeyboard() {
        print("delegateのcloseKeyboardが呼ばれた")
    }
}


#Preview {
    CustomViewController()
}
