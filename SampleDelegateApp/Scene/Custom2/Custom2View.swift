//
//  Custom2View.swift
//  SampleDelegateApp
//
//  Created by sakiyamaK on 2025/02/01.
//

//
import UIKit

final class Custom2View: UIView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        var config = UIButton.Configuration.plain()
        config.title = "ボタンだよ"
        let button = UIButton(configuration: config)
        button.addAction(.init(handler: {[weak self] _ in
            guard let self else { return }
            print("ボタンをタップしたよ")
            self.delegate?.tapButton()
        }), for: .touchUpInside)
        return button
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        textView.border(width: 1, color: .black, cornerRadius: 16)
        textView.delegate = self
        return textView
    }()

    // クロージャーでDelegateを表現してもいい
    struct Delegate {
        var tapButton: (() -> Void)
        var closeKeyboard: (() -> Void)
    }
    // クロージャならこのように独立させてもいい
//    var tapButton: (() -> Void)?

    var delegate: Delegate?

    init() {
        super.init(frame: .zero)

        self.addSubview(stackView)
        stackView.applyArroundConstraint(equalTo: self)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(button)

    }
}

extension Custom2View: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("キーボードを閉じたよ")
        delegate?.closeKeyboard()
        return true
    }
}
