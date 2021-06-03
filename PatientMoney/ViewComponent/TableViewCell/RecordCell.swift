import Foundation
import UIKit

class RecordCell: UITableViewCell {
    var categoryTitle = L10n.CategoryIcon.Title.pizzaSlice {
        didSet {
            updateValue()
        }
    }

    var money = 0 {
        didSet {
            updateValue()
        }
    }

    static let reuseIdentifer = "patience-record"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    private func construct() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(icon)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(moneyLabel)

        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor),

            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5),

            moneyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moneyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3),
            moneyLabel.leftAnchor.constraint(greaterThanOrEqualTo: titleLabel.rightAnchor)
        ])
    }

    private let icon = UILabel()

    private let titleLabel = UILabel()

    private let moneyLabel = UILabel()

    private func updateValue() {
        let category = Category.categories.filter {
            $0.title == categoryTitle
        }
        icon.attributedText = NSAttributedString.icon(category[0].icon, size: 20, style: .solid)
        icon.textColor = category[0].color

        titleLabel.text = category[0].title

        moneyLabel.text = String(money) + "円"
    }
}
