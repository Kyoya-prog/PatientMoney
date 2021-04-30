import Foundation
import UIKit

class SignInViewController: AuthViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        super.titleLabel.text = L10n.AuthViewController.SignIn.TitleLabel.text
        super.finishButton.setTitle(L10n.AuthViewController.SignIn.DecideButton.title, for: .normal)
        super.changeViewLabel.attributedText = NSAttributedString(string: L10n.AuthViewController.SignIn.ChangeViewLabel.text, attributes: [.foregroundColor: UIColor(hex: "5BCAFF"), .underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    override func finishButtonAction() {
        presenter.didTapSigninFinishButton(mailAddress: mailAddressTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    override func changeViewLabelAction() {
        presenter.didTapSignInChangeViewLabel()
    }
}
