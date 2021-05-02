import Foundation
import UIKit

class MoneyView: UIView {
    /// 金額
    var money: Int {
        get {
            Int(moneyTextField.text ?? "") ?? 0
        }
        set {
            moneyTextField.text = String(newValue)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    // MARK: Private

    private func construct() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = L10n.MoneyView.title
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(titleLabel)

        moneyTextField.translatesAutoresizingMaskIntoConstraints = false

        moneyTextField.backgroundColor = UIColor(hex: "F0E68C")
        moneyTextField.textInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        moneyTextField.placeholder = "0"
        moneyTextField.font = UIFont.boldSystemFont(ofSize: 20)
        moneyTextField.layer.cornerRadius = 4
        moneyTextField.keyboardType = .numberPad
        addSubview(moneyTextField)

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction(_:)))
        toolBar.setItems([doneItem], animated: true)
        toolBar.sizeToFit()

        moneyTextField.inputAccessoryView = toolBar

        yenLabel.translatesAutoresizingMaskIntoConstraints = false
        yenLabel.text = "円"
        yenLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(yenLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 50),

            yenLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            yenLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            yenLabel.widthAnchor.constraint(equalToConstant: 50),

            moneyTextField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            moneyTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            moneyTextField.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20),
            moneyTextField.rightAnchor.constraint(equalTo: yenLabel.leftAnchor, constant: -5)
        ])
    }

    private let titleLabel = UILabel()

    private let moneyTextField = PatienceTextField()

    private let yenLabel = UILabel()

    @objc private func doneButtonAction(_ : UIBarButtonItem) {
        moneyTextField.endEditing(true)
    }
}
