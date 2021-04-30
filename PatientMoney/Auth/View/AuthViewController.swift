import Foundation
import UIKit

/// アカウント情報入力 ViewController
class AuthViewController: UIViewController, AuthView {
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

    // MARK: AuthView
    var presenter: AuthPresentation!

    func showError(message: String) {
    }

    func enableFinishButton(isEnabled: Bool) {
        finishButton.isEnabled = isEnabled
    }

    // MARK: Private

    private let mailAddressLabel = UILabel()

    private let passwordLabel = UILabel()

    private let titleLabel = UILabel()

    private let mailAddressTextField = PatienceTextField()

    private let passwordTextField = PatienceTextField()

    private let finishButton = FlatButton()

    private let changeInputLabel = UILabel()

    private let authErrorLabel = UILabel()

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
        mailAddressTextField.addTarget(self, action: #selector(didChangeMailAddressTextField(_:)), for: .editingChanged)
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
        passwordTextField.addTarget(self, action: #selector(didChangePasswordTextField(_:)), for: .editingChanged)
        view.addSubview(passwordTextField)

        finishButton.translatesAutoresizingMaskIntoConstraints = false
        
        finishButton.addTarget(self, action: #selector(didTapFinishButton(_:)), for: .touchUpInside)
        finishButton.isEnabled = false
        view.addSubview(finishButton)

        authErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        authErrorLabel.font = UIFont.systemFont(ofSize: 14)
        authErrorLabel.textColor = UIColor(hex: "FFA07A")
        authErrorLabel.isHidden = true
        view.addSubview(authErrorLabel)

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

            authErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3),
            authErrorLabel.leftAnchor.constraint(equalTo: mailAddressLabel.leftAnchor),
            authErrorLabel.rightAnchor.constraint(equalTo: mailAddressLabel.rightAnchor),

            finishButton.topAnchor.constraint(equalTo: authErrorLabel.bottomAnchor, constant: 30),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            changeInputLabel.topAnchor.constraint(greaterThanOrEqualTo: finishButton.bottomAnchor),
            changeInputLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeInputLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

    private func setTextValue() {
        mailAddressLabel.text = L10n.AuthViewController.MailAddressLabel.text
        mailAddressTextField.placeholder = L10n.AuthViewController.MailAddressTextField.placeholder
        passwordLabel.text = L10n.AuthViewController.PasswordLabel.text
        passwordTextField.placeholder = L10n.AuthViewController.PasswordTextField.placeholder
        var attributedString: NSAttributedString
        switch inputMode {
        case .signIn:
            titleLabel.text = L10n.AuthViewController.SignIn.TitleLabel.text
            finishButton.setTitle(L10n.AuthViewController.SignIn.DecideButton.title, for: .normal)
            changeInputLabel.text = L10n.AuthViewController.SignIn.ChengeModeLabel.text
            attributedString = NSAttributedString(string: L10n.AuthViewController.SignIn.ChengeModeLabel.text, attributes: [.foregroundColor: UIColor(hex: "5BCAFF"), .underlineStyle: NSUnderlineStyle.single.rawValue])

        case .signUp:
            titleLabel.text = L10n.AuthViewController.SignUp.TitleLabel.text
            finishButton.setTitle(L10n.AuthViewController.SignUp.DecideButton.title, for: .normal)
            changeInputLabel.text = L10n.AuthViewController.SignUp.ChangeModeLabel.text
            attributedString = NSAttributedString(string: L10n.AuthViewController.SignUp.ChangeModeLabel.text, attributes: [.foregroundColor: UIColor(hex: "5BCAFF"), .underlineStyle: NSUnderlineStyle.single.rawValue])
        }
        changeInputLabel.attributedText = attributedString
    }

    @objc private func didChangeMailAddressTextField(_ sender: PatienceTextField) {
        guard let passwprd = passwordTextField.text, let mailAddress = mailAddressTextField.text else { return }
        finishButton.isEnabled = !passwprd.isEmpty && !mailAddress.isEmpty
    }

    @objc private func didChangePasswordTextField(_ sender: PatienceTextField) {
        guard let password = passwordTextField.text else { return }
        finishButton.isEnabled = 8 <= password.count
        if !finishButton.isEnabled {
            authErrorLabel.text = "パスワードは８文字以上入力してください"
            authErrorLabel.isHidden = false
        } else {
            authErrorLabel.isHidden = true
        }
    }

    @objc private func didTapFinishButton(_ sender: UIButton) {
        presenter.didTapFinishButton(mailAddress: mailAddressTextField.text ?? "", password: passwordTextField.text ?? "", isSignIn: inputMode == .signIn)
    }
}

