//
//  CustomView.swift
//  SampleDelegateApp
//
//  Created by sakiyamaK on 2024/07/16.
//

import UIKit

protocol CustomViewDelegate {
    func tapButton()
    func closeKeyboard()
}

final class CustomView: UIView {
    // コードでレイアウトを組む場合はこれが必要
    // storyboardから読まないことを明示している
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // privateにすることでframeで座標を作ることもないよと明示する
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var button: UIButton = {
        // こういうConfigurationという設定を用意してViewを作るやり方が
        // iOS16?あたりから追加されてきたトレンド機能
        // 2024.07現在、全てのViewが対応されているわけではないが徐々に増えてくると思う
        var config = UIButton.Configuration.plain()
        config.title = "ボタンだよ"
        let button = UIButton(configuration: config)
        button.addAction(.init(handler: {[weak self] _ in
            guard let self else { return }
            print("ボタンをタップしたよ")
            // この実装を書いてる段階ではどのインスタンスから呼ばれるのか分からない
            // 誰かは知らないがdelegate(CustomViewDelegateのメソッドを持ってるインスタンス)に後は任せる
            self.delegate?.tapButton()
        }), for: .touchUpInside)
        return button
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.border(width: 1, color: .black, cornerRadius: 16)
        textView.delegate = self
        return textView
    }()
    
    // この実装を書いてる段階ではどのインスタンスから呼ばれるのか分からない
    // CustomViewDelegateのメソッドを持ってるインスタンスしか代入できない
    var delegate: CustomViewDelegate?
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(stackView)
        stackView.applyArroundConstraint(equalTo: self)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(button)

    }
}

extension CustomView: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("キーボードを閉じたよ")
        // この実装を書いてる段階ではどのインスタンスから呼ばれるのか分からない
        // 誰かは知らないがdelegate(CustomViewDelegateのメソッドを持ってるインスタンス)に後は任せる
        delegate?.closeKeyboard()
        return true
    }
}

//#Preview {
//    CustomView()
//}
