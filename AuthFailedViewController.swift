import Foundation
import UIKit

class AuthFailedViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message + errorCauseMessage
        label.textColor = .gray
        label.numberOfLines = 0
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 100),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -100)
        ])
    }

    var errorCauseMessage: String = ""

    private let message = "認証に失敗しました。"

    private let label = UILabel()
}
