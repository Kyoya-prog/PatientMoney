import Foundation
import UIKit

/// アカウント情報入力 ViewController
class AccountViewController: UIViewController {
    enum InputMode {
        case signIn
        case signUp
    }

    // MARK: Initialize

    required init?(coder: NSCoder) {
        self.inputMode = .signIn
        super.init(coder: coder)
    }

    init(inputMode: InputMode) {
        self.inputMode = inputMode
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: Private

    private let mailAddressLabel = UILabel()

    private let passwordLabel = UILabel()

    private let titleLabel = UILabel()

    private let mailAddressTextField = PatienceTextField()

    private let passwordTextField = PatienceTextField()

    private let finishButton = UIButton()

    private let changeInputLabel = UILabel()

    private var inputMode: InputMode

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        construct()
        setTextValue()
    }

    private func construct() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = UIColor(hex: "FFA488")
        view.addSubview(titleLabel)

        mailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        mailAddressLabel.font = UIFont.systemFont(ofSize: 14)
        mailAddressLabel.textColor = .black
        view.addSubview(mailAddressLabel)

        mailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        mailAddressTextField.font = UIFont.systemFont(ofSize: 14)
        mailAddressTextField.layer.borderWidth = 1
        mailAddressTextField.layer.borderColor = UIColor(hex: "FFA500").cgColor
        mailAddressTextField.layer.cornerRadius = 4
        mailAddressTextField.textColor = .black
        mailAddressTextField.delegate = self
        view.addSubview(mailAddressTextField)

        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.font = UIFont.systemFont(ofSize: 14)
        passwordLabel.textColor = .black
        view.addSubview(passwordLabel)

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.layer.borderColor = UIColor(hex: "FFA500").cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .black
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)

        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.backgroundColor = UIColor(hex: "FFA498")
        view.addSubview(finishButton)

        changeInputLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeInputLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            mailAddressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            mailAddressLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            mailAddressLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),

            mailAddressTextField.topAnchor.constraint(equalTo: mailAddressLabel.bottomAnchor, constant: 10),
            mailAddressTextField.leftAnchor.constraint(equalTo: mailAddressLabel.leftAnchor),
            mailAddressTextField.rightAnchor.constraint(equalTo: mailAddressLabel.rightAnchor),

            passwordLabel.topAnchor.constraint(equalTo: mailAddressTextField.bottomAnchor, constant: 20),
            passwordLabel.leftAnchor.constraint(equalTo: mailAddressLabel.leftAnchor),
            passwordLabel.rightAnchor.constraint(equalTo: mailAddressLabel.rightAnchor),

            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: mailAddressLabel.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: mailAddressLabel.rightAnchor),

            finishButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            changeInputLabel.topAnchor.constraint(greaterThanOrEqualTo: finishButton.bottomAnchor),
            changeInputLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeInputLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

    private func setTextValue() {
        mailAddressLabel.text = L10n.AccountViewController.MailAddressLabel.text
        mailAddressTextField.placeholder = L10n.AccountViewController.MailAddressTextField.placeholder
        passwordLabel.text = L10n.AccountViewController.PasswordLabel.text
        passwordTextField.placeholder = L10n.AccountViewController.PasswordTextField.placeholder
        var attributedString: NSAttributedString
        switch inputMode {
        case .signIn:
            titleLabel.text = L10n.AccountViewController.SignIn.TitleLabel.text
            finishButton.setTitle(L10n.AccountViewController.SignIn.DecideButton.title, for: .normal)
            changeInputLabel.text = L10n.AccountViewController.SignIn.ChengeModeLabel.text
            attributedString = NSAttributedString(string: L10n.AccountViewController.SignIn.ChengeModeLabel.text, attributes: [.foregroundColor: UIColor(hex: "5BCAFF"), .underlineStyle: NSUnderlineStyle.single.rawValue])

        case .signUp:
            titleLabel.text = L10n.AccountViewController.SignUp.TitleLabel.text
            finishButton.setTitle(L10n.AccountViewController.SignUp.DecideButton.title, for: .normal)
            changeInputLabel.text = L10n.AccountViewController.SignUp.ChangeModeLabel.text
            attributedString = NSAttributedString(string: L10n.AccountViewController.SignUp.ChangeModeLabel.text, attributes: [.foregroundColor: UIColor(hex: "5BCAFF"), .underlineStyle: NSUnderlineStyle.single.rawValue])
        }
        changeInputLabel.attributedText = attributedString
    }
}

extension AccountViewController: UITextFieldDelegate {
}
