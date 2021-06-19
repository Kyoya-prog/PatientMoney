import Foundation
import UIKit

/// 月毎に選択するかをチェックするView
class DateSelectStyleCheckView: UIView {
    var isChecked: Bool = false

    var didToggleCheckBoxAction:((_ isChecked: Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    private func construct() {
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.checkBoxSelectedAction = { [weak self] isOn in
            self?.isChecked = isOn
        }

        addSubview(checkBox)

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = L10n.DateSelectStyleCheckView.DescriptionLabel.text
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),

            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBox.leftAnchor.constraint(equalTo: leftAnchor),

            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: checkBox.rightAnchor, constant: 20),
            descriptionLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor)
        ])
    }

    private let checkBox = CheckBox()

    private let descriptionLabel = UILabel()
}

#if canImport(SwiftUI)
import  SwiftUI

struct DateSelectStyleCheckViewWrapper: UIViewRepresentable {
    typealias UIViewType = DateSelectStyleCheckView

    func makeUIView(context: Context) -> DateSelectStyleCheckView {
        DateSelectStyleCheckView()
    }

    func updateUIView(_ uiView: DateSelectStyleCheckView, context: Context) {
    }
}

struct DateSelectStyleCheckViewPreviews: PreviewProvider {
    static var previews: some View {
        DateSelectStyleCheckViewWrapper()
        .previewLayout(.fixed(width: 500, height: 100))
    }
}
#endif
