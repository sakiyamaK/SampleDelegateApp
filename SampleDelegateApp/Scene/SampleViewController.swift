//
//  ViewController.swift
//  SampleDelegateApp
//
//  Created by sakiyamaK on 2024/07/15.
//

import UIKit
import WebKit

final class SampleViewController: UIViewController {

    // letではselfが存在しないため代入できない
    // lazyは呼び出す時に初めて実行される
    // ここで代入しているのは{ }という名前のない関数（クロージャーという）
    // さらにその名前のない関数{}を定義した直後に()として実行している(関数の即時実行)
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.delegate = self
        return searchBar
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.delegate = self
        return textField
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.apply(constraint: textView.heightAnchor.constraint(equalToConstant: 300))
        textView.border(width: 1, color: .black, cornerRadius: 16)
        return textView
    }()

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: "https://kadokawadwango-it-university.jp/")!))
        webView.apply(constraint: webView.heightAnchor.constraint(equalToConstant: 500))

        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(scrollView)
        
        // scrollViewの四隅をviewのsafeAreaに合わせる制約を貼る
        scrollView.applyArroundConstraint(equalTo: self.view.safeAreaLayoutGuide)

        scrollView.addSubview(stackView)
        
        // scrollViewで縦スクロールするようにstackViewの制約を貼る
        scrollView.applyScrollConstraint(stackView, direction: .vertical, constants: (0, 16, 0 ,16))

        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(webView)
    }
}

extension SampleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension SampleViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        return true
    }
}

extension SampleViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
}

extension SampleViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(text)
        return true
    }
}

extension SampleViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("ローディング")
    }
}


#Preview {
    SampleViewController()
}
