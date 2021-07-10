import UIKit

/// padding付きのテキストフィールド（アプリ内では原則このtextfieldを使用する）
class PatienceTextField: UITextField {
    /// テキストの表示インセット
    public var textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet { layoutIfNeeded() }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
}
