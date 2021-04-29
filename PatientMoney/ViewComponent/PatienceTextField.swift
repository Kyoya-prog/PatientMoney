import UIKit

/// padding付きのテキストフィールド（アプリ内では原則このtextfieldを使用する）
class PatienceTextField: UITextField {
    private let padding: CGFloat = 8

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
}
