import Foundation
import UIKit

class MemoView: UIView {
    /// メモ
    var memo: String {
        get {
            memoTextView.text
        }
        set {
            memoTextView.text = newValue
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.text = L10n.MemoView.title
        titleLabel.textColor = UIColor.black
        addSubview(titleLabel)

        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        memoTextView.layer.cornerRadius = 4
        memoTextView.backgroundColor = UIColor(hex: "DCDCDC")
        memoTextView.font = UIFont.systemFont(ofSize: 20)
        memoTextView.textContainerInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        memoTextView.text = L10n.MemoView.MemoTextView.text
        memoTextView.isScrollEnabled = false
        memoTextView.textColor = UIColor.black
        addSubview(memoTextView)

        memoTextView.inputAccessoryView = keyboardToolbar

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 50),

            memoTextView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20),
            memoTextView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            memoTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            memoTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
        ])
    }

    private let titleLabel = UILabel()

    private let memoTextView = UITextView()

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
        memoTextView.endEditing(true)
    }
}
