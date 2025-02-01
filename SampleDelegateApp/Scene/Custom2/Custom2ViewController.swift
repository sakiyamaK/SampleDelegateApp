//
//  Custom2ViewController.swift
//  SampleDelegateApp
//
//  Created by sakiyamaK on 2025/02/01.
//

import UIKit

final class Custom2ViewController: UIViewController {

    private lazy var custom2View: Custom2View = {
        let customView = Custom2View()
        // delegateの実装が下に分離せずに書ける
        customView.delegate = .init(tapButton: {
            print("delegateのtapButtonが呼ばれた")
        }, closeKeyboard: {
            print("delegateのcloseKeyboardが呼ばれた")
        })
        return customView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(custom2View)
        custom2View.applyArroundConstraint(
            equalTo: self.view.safeAreaLayoutGuide,
            constants: (8, 8, 8, 8)
        )
    }
}

#Preview {
    Custom2ViewController()
}
