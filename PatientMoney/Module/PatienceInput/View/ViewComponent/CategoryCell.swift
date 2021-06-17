import UIKit

/// カテゴリーセル
class CategoryCell: UICollectionViewCell {
    static let reuseIdentifer = "category-cell"

    /// アイコン
    var icon: FontAwesome.Icon {
        get {
            .pizzaSlice
        }
        set {
            iconLabel.attributedText = NSAttributedString.icon(newValue, size: 50, style: .solid)
        }
    }

    /// アイコンの色
    var color: UIColor {
        get {
            iconLabel.textColor
        }
        set {
            iconLabel.textColor = newValue
        }
    }

    /// アイコンタイトル
    var title: String {
        get {
            titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }

    /// アイコンが選択されているかどうか
    var isSelectedCell: Bool = false {
        didSet {
            updateDisplay()
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

    override func prepareForReuse() {
        super.prepareForReuse()
        title = ""
    }

    private func construct() {
        layer.borderWidth = 1
        layer.cornerRadius = 4

        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.textAlignment = .center
        contentView.addSubview(iconLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            iconLabel.heightAnchor.constraint(equalToConstant: 50),
            iconLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])

        updateDisplay()
    }

    private func updateDisplay() {
        layer.borderColor = isSelectedCell ? UIColor(hex: "808080").cgColor:UIColor(hex: "DCDCDC").cgColor
    }

    private let iconLabel = UILabel()

    private let titleLabel = UILabel()
}
