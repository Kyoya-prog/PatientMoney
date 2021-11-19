import Foundation
import UIKit

class MoneyView: PatienceInputViewComponent {
    /// 金額
    var money: Int? {
        get {
            Int(moneyTextField.text ?? "")
        }
        set {
            moneyTextField.text = String(newValue ?? 0)
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

    override func resetView() {
        moneyTextField.text = nil
    }

    // MARK: Private

    private func construct() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = L10n.MoneyView.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        addSubview(titleLabel)

        moneyTextField.translatesAutoresizingMaskIntoConstraints = false

        moneyTextField.backgroundColor = UIColor(hex: "F0E68C")
        moneyTextField.textInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        moneyTextField.placeholder = L10n.MoneyView.MoneyTextField.placeholder
        moneyTextField.font = UIFont.boldSystemFont(ofSize: 20)
        moneyTextField.layer.cornerRadius = 4
        moneyTextField.keyboardType = .numberPad
        moneyTextField.textColor = UIColor.black
        moneyTextField.placeholder = "0"
        moneyTextField.delegate = self
        addSubview(moneyTextField)

        moneyTextField.inputAccessoryView = keyboardToolbar

        yenLabel.translatesAutoresizingMaskIntoConstraints = false
        yenLabel.text = L10n.MoneyView.YenLabel.text
        yenLabel.font = UIFont.systemFont(ofSize: 14)
        yenLabel.textColor = UIColor.black
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

    private lazy var keyboardToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction(_:)))
        ]
        toolbar.sizeToFit()
        return toolbar
    }()

    @objc private func doneButtonAction(_ : UIBarButtonItem) {
        moneyTextField.endEditing(true)
    }
}

extension MoneyView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultText: String = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        guard let money = Int(resultText) else { fatalError() }
        if money > 1000000000 {
            moneyTextField.text = "99999999"
            return false
        } else {
            return true
        }
    }
}
