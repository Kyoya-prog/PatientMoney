import Foundation
import UIKit

/// ログインViewController
class LoginViewController: UIViewController {
    enum InputMode {
        case signIn

        case signUp
    }

    required init?(coder: NSCoder) {
        self.inputMode = .signIn
        super.init(coder: coder)
    }

    init(inputMode: InputMode) {
        self.inputMode = inputMode
        super.init(nibName: nil, bundle: nil)
    }

    private let mailAddressLabel = UILabel()

    private let passwordLabel = UILabel()

    private let loginTitleLabel = UILabel()

    private let mailAddressTextField = PatienceTextField()

    private let passwordTextField = PatienceTextField()

    private let loginButton = UIButton()

    private var inputMode: InputMode

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        construct()
    }

    private func construct() {
        loginTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        loginTitleLabel.textColor = UIColor(hex: "FFA488")
        loginTitleLabel.text = L10n.LoginViewController.LoginTitleLabel.text
        view.addSubview(loginTitleLabel)

        mailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        mailAddressLabel.font = UIFont.systemFont(ofSize: 14)
        mailAddressLabel.text = L10n.LoginViewController.MailAddressLabel.text
        mailAddressLabel.textColor = .black
        view.addSubview(mailAddressLabel)

        mailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        mailAddressTextField.font = UIFont.systemFont(ofSize: 14)
        mailAddressTextField.layer.borderWidth = 1
        mailAddressTextField.layer.borderColor = UIColor(hex: "FFA500").cgColor
        mailAddressTextField.layer.cornerRadius = 4
        mailAddressTextField.placeholder = L10n.LoginViewController.MailAddressTextField.placeholder
        mailAddressTextField.textColor = .black
        mailAddressTextField.delegate = self
        view.addSubview(mailAddressTextField)

        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.font = UIFont.systemFont(ofSize: 14)
        passwordLabel.text = L10n.LoginViewController.PasswordLabel.text
        passwordLabel.textColor = .black
        view.addSubview(passwordLabel)

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.layer.borderColor = UIColor(hex: "FFA500").cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = L10n.LoginViewController.PasswordTextField.placeholder
        passwordTextField.textColor = .black
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = UIColor(hex: "FFA498")
        loginButton.setTitle(L10n.LoginViewController.LoginButton.title, for: .normal)
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            loginTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            loginTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            mailAddressLabel.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 20),
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

            loginButton.topAnchor.constraint(greaterThanOrEqualTo: passwordTextField.bottomAnchor),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
}
