import UIKit

class RecordCell: UITableViewCell {
    static let reuseIdentifer = "patience-record"

    /// カテゴリータイトル
    var categoryTitle = L10n.CategoryIcon.Title.pizzaSlice {
        didSet {
            updateValue()
        }
    }

    /// 金額
    var money = 0 {
        didSet {
            updateValue()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    private func construct() {
        contentView.backgroundColor = UIColor(hex: "FFDA85")

        icon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(icon)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)

        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.textColor = UIColor.black
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
        let category = Category.allCases.filter {
            $0.title == categoryTitle
        }
        icon.attributedText = NSAttributedString.icon(category[0].icon, size: 20, style: .solid)
        icon.textColor = category[0].color

        titleLabel.text = category[0].title

        moneyLabel.text = String(money) + "円"
    }
}
