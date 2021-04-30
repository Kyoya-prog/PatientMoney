import Foundation
import UIKit

/// アカウント情報入力 ViewController
class AuthViewController: UIViewController, AuthView {
    enum InputMode {
        case signIn
        case signUp
    }

    let titleLabel = UILabel()

    let mailAddressTextField = PatienceTextField()

    let passwordTextField = PatienceTextField()

    let finishButton = FlatButton()

    let changeViewLabel = UILabel()

    let authErrorLabel = UILabel()

    func finishButtonAction() {
        fatalError("this method must be overrided")
    }

    func changeViewLabelAction() {
        fatalError("this method must be overrided")
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        construct()
    }

    private func construct() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = UIColor(hex: "FFA488")
        view.addSubview(titleLabel)

        mailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        mailAddressLabel.font = UIFont.systemFont(ofSize: 14)
        mailAddressLabel.textColor = .black
        mailAddressLabel.text = L10n.AuthViewController.MailAddressLabel.text
        view.addSubview(mailAddressLabel)

        mailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        mailAddressTextField.font = UIFont.systemFont(ofSize: 14)
        mailAddressTextField.layer.borderWidth = 1
        mailAddressTextField.layer.borderColor = UIColor(hex: "FFA500").cgColor
        mailAddressTextField.layer.cornerRadius = 4
        mailAddressTextField.textColor = .black
        mailAddressTextField.placeholder = L10n.AuthViewController.MailAddressTextField.placeholder
        mailAddressTextField.addTarget(self, action: #selector(didChangeMailAddressTextField(_:)), for: .editingChanged)
        view.addSubview(mailAddressTextField)

        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.font = UIFont.systemFont(ofSize: 14)
        passwordLabel.textColor = .black
        passwordLabel.text = L10n.AuthViewController.PasswordLabel.text
        view.addSubview(passwordLabel)

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.layer.borderColor = UIColor(hex: "FFA500").cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .black
        passwordTextField.placeholder = L10n.AuthViewController.PasswordTextField.placeholder
        view.addSubview(passwordTextField)

        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.isEnabled = false
        finishButton.addTarget(self, action: #selector(didTapFinishButton(_:)), for: .touchUpInside)
        view.addSubview(finishButton)

        authErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        authErrorLabel.font = UIFont.systemFont(ofSize: 14)
        authErrorLabel.textColor = UIColor(hex: "FFA07A")
        authErrorLabel.isHidden = true
        view.addSubview(authErrorLabel)

        changeViewLabel.translatesAutoresizingMaskIntoConstraints = false
        changeViewLabel.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapChangeViewLabel(_:)))
        changeViewLabel.addGestureRecognizer(tapRecognizer)
        changeViewLabel.isUserInteractionEnabled = true
        view.addSubview(changeViewLabel)

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

            changeViewLabel.topAnchor.constraint(greaterThanOrEqualTo: finishButton.bottomAnchor),
            changeViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeViewLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

    @objc private func didChangeMailAddressTextField(_ sender: PatienceTextField) {
        guard let passwprd = passwordTextField.text, let mailAddress = mailAddressTextField.text else { return }
        finishButton.isEnabled = !passwprd.isEmpty && !mailAddress.isEmpty
    }

    @objc private func didTapFinishButton(_ sender: UIButton) {
        finishButtonAction()
    }

    @objc private func didTapChangeViewLabel(_ sender: UIButton) {
        changeViewLabelAction()
    }
}
