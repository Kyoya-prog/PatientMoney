import Foundation
import UIKit

class AuthFailedViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "データの読み込みに失敗しました。ネットワーク接続環境をご確認の上、もう一度アプリを再起動してください。"
        label.numberOfLines = 0
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }

    private let label = UILabel()
}
