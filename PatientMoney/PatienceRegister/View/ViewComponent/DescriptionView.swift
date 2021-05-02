import Foundation
import UIKit

class DescriptionView: UIView {
    /// メモ
    var memo: String {
        get {
            descriptionTextView.text
        }
        set {
            descriptionTextView.text = newValue
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
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.text = L10n.DescriptionView.title
        addSubview(titleLabel)

        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.layer.cornerRadius = 4
        descriptionTextView.backgroundColor = UIColor(hex: "DCDCDC")
        descriptionTextView.font = UIFont.systemFont(ofSize: 20)
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        descriptionTextView.text = L10n.DescriptionView.DescriptionTextView.text
        descriptionTextView.isScrollEnabled = false
        addSubview(descriptionTextView)

        descriptionTextView.inputAccessoryView = keyboardToolbar

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 50),

            descriptionTextView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20),
            descriptionTextView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
        ])
    }

    private let titleLabel = UILabel()

    private let descriptionTextView = UITextView()

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
        descriptionTextView.endEditing(true)
    }
}
