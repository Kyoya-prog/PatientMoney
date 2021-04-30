import UIKit

/// ボタンの状態で背景色が変わるFlatButton
class FlatButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    private func construct() {
        layer.cornerRadius = 4
    }
    override public var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = UIColor(hex: "FFA498")
            } else {
                backgroundColor = UIColor(hex: "9D9D9D")
            }
        }
    }
}
