import Foundation
import UIKit

class DescriptionView: UIView {
    
    var memo:String{
        get {
            descriptionTextView.text
        }
        set{
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

    private func construct() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = L10n.DescriptionView.title
        addSubview(titleLabel)

        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.layer.cornerRadius = 4
        descriptionTextView.backgroundColor = UIColor(hex: "DCDCDC")
        descriptionTextView.font = UIFont.systemFont(ofSize: 20)
        descriptionTextView.text = L10n.DescriptionView.DescriptionTextView.text
        descriptionTextView.isScrollEnabled = false
        addSubview(descriptionTextView)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 50),

            descriptionTextView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20),
            descriptionTextView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }

    private let titleLabel = UILabel()

    private let descriptionTextView = UITextView()
}
