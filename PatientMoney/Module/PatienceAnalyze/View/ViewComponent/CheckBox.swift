import Foundation
import UIKit

/// CheckBox
class CheckBox: UIControl {
    /// チェックされているかどうか
    var isOn = false {
        didSet {
            updateDisplay()
        }
    }

    /// チェックボックスが選択された時のアクション
    var checkBoxSelectedAction:((_ isOn: Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }
    private func construct() {
        addTarget(self, action: #selector(touchAction(_:)), for: .touchUpInside)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.attributedText = NSAttributedString.icon(FontAwesome.Icon.check, size: 20)
        iconLabel.textAlignment = .center
        iconLabel.layer.cornerRadius = 4
        iconLabel.clipsToBounds = true
        addSubview(iconLabel)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 30),
            widthAnchor.constraint(equalToConstant: 30),
            iconLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconLabel.widthAnchor.constraint(equalToConstant: 30),
            iconLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        updateDisplay()
    }

    @objc private func touchAction(_ sender: UIControl) {
        isOn.toggle()
        backgroundColor = .red
        checkBoxSelectedAction?(isOn)
    }

    private let iconLabel = UILabel()

    private func updateDisplay() {
        if !isOn {
            iconLabel.layer.borderWidth = 1
        }
        switch (isOn, isHighlighted) {
        case (false, false):
            iconLabel.textColor = .black
            iconLabel.backgroundColor = .white

        case (true, false):
            iconLabel.textColor = .white
            iconLabel.backgroundColor = .gray

        case (_, true):
            iconLabel.textColor = .white
            iconLabel.backgroundColor = UIColor(hex: "cccccc")
        }
    }

    override var isHighlighted: Bool {
        didSet {
            updateDisplay()
        }
    }
}

#if canImport(SwiftUI)
import  SwiftUI

struct CheckBoxWrapper: UIViewRepresentable {
    var isOn: Bool

    var isHighlighted: Bool

    typealias UIViewType = CheckBox

    func makeUIView(context: Context) -> CheckBox {
        CheckBox()
    }

    func updateUIView(_ uiView: CheckBox, context: Context) {
        uiView.isOn = isOn
        uiView.isHighlighted = isHighlighted
    }
}

struct CheckBoxPreviews: PreviewProvider {
    static var previews: some View {
        CheckBoxWrapper(isOn: true, isHighlighted: true
        ).previewDisplayName("isSelected and isHighlighted")
        .previewLayout(.fixed(width: 50, height: 50))
        CheckBoxWrapper(isOn: true, isHighlighted: false
        ).previewDisplayName("isOn and not highlighted")
        .previewLayout(.fixed(width: 50, height: 50))
        CheckBoxWrapper(isOn: false, isHighlighted: false
        ).previewDisplayName("not selected and not highlighted")
        .previewLayout(.fixed(width: 50, height: 50))
    }
}

#endif
