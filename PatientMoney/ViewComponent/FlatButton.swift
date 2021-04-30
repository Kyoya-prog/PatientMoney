import UIKit

/// ボタンの状態で背景色が変わるFlatButton
class FlatButton: UIButton {
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
