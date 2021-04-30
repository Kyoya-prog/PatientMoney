import Foundation
import UIKit

class SignUpViewController: AuthViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        super.titleLabel.text = L10n.AuthViewController.SignUp.TitleLabel.text
        super.finishButton.setTitle(L10n.AuthViewController.SignUp.DecideButton.title, for: .normal)
        super.changeViewLabel.attributedText = NSAttributedString(string: L10n.AuthViewController.SignUp.ChangeViewLabel.text, attributes: [.foregroundColor: UIColor(hex: "5BCAFF"), .underlineStyle: NSUnderlineStyle.single.rawValue])

        passwordTextField.addTarget(self, action: #selector(didChangePasswordTextField(_:)), for: .editingChanged)
    }

    @objc private func didChangePasswordTextField(_ sender: PatienceTextField) {
        guard let password = passwordTextField.text else { return }
        finishButton.isEnabled = 8 <= password.count
        if !finishButton.isEnabled {
            authErrorLabel.text = L10n.AuthViewController.passwordMustMoreEightCharacters
            authErrorLabel.isHidden = false
        } else {
            authErrorLabel.isHidden = true
        }
    }

    override func finishButtonAction() {
        presenter.didTapFinishSignUpButton(mailAddress: mailAddressTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    override func changeViewLabelAction() {
    }
}
