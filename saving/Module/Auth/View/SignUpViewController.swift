import Foundation
import UIKit

class SignUpViewController: AuthViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        super.titleLabel.text = L10n.AuthViewController.SignUp.TitleLabel.text
        super.finishButton.setTitle(L10n.AuthViewController.SignUp.DecideButton.title, for: .normal)
        super.changeViewLabel.attributedText = NSAttributedString(string: L10n.AuthViewController.SignUp.ChangeViewLabel.text, attributes: [.foregroundColor: UIColor(hex: "5BCAFF"), .underlineStyle: NSUnderlineStyle.single.rawValue])
        super.changeDescriptionLabel.text = L10n.AuthViewController.SignUp.ChangeDesctiptionLabel.text
    }

    override func finishButtonAction() {
        presenter.didTapSignUpFinishButton(mailAddress: mailAddressTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    override func changeViewLabelAction() {
        presenter.didTapSignUpChangeViewLabel()
    }

    override func mailAddressTextFiledChangeAction() {
        guard let passwprd = passwordTextField.text, let mailAddress = mailAddressTextField.text else { return }
        finishButton.isEnabled = !passwprd.isEmpty && !mailAddress.isEmpty
    }

    override func passwordTextFieldChangeAction() {
        guard let password = passwordTextField.text else { return }
        presenter.checkPasswordLength(password: password)
    }
}
