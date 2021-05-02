import Foundation
import UIKit

/// カテゴリーView
class CategoriesView: UIView {
    /// 選択されたカテゴリータイトル
    var selectedCategoryTitle: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    // MARK: Private
    private let categories:[(icon: FontAwesome.Icon, title: String, color: UIColor)] = [
        (icon:.pizzaSlice, title:L10n.CategoriesView.IconTitle.pizzaSlice, UIColor(hex: "FFA500")),
        (icon:.bus, title:L10n.CategoriesView.IconTitle.bus, UIColor(hex: "00BFFF")),
        (icon:.paintBrush, title:L10n.CategoriesView.IconTitle.paintBrush, UIColor(hex: "00FF00"))
    ]

    private func construct() {
        categoriesView.translatesAutoresizingMaskIntoConstraints = false
        categoriesView.delegate = self
        categoriesView.dataSource = self
        addSubview(categoriesView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = L10n.CategoriesView.title
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),

            categoriesView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoriesView.leftAnchor.constraint(equalTo: leftAnchor),
            categoriesView.rightAnchor.constraint(equalTo: rightAnchor),
            categoriesView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private lazy var categoriesViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }()

    private lazy var categoriesView: UICollectionView = {
        let view = HeightSelfSizingCollectionView(frame: frame, collectionViewLayout: categoriesViewLayout)
        view.backgroundColor = .clear
        view.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifer)
        return view
    }()

    private let titleLabel = UILabel()
}

// MARK: CollectionViewDelegateMethod
extension CategoriesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10
        let height = CGFloat(80)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifer, for: indexPath) as! CategoryCell
        let category = categories[indexPath.item]
        cell.icon = category.icon
        cell.title = category.title
        cell.color = category.color
        cell.isSelectedCell = category.title == selectedCategoryTitle
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        selectedCategoryTitle = category.title
        categoriesView.reloadData()
    }
}

/// categpriesViewのcellクラス
private class CategoryCell: UICollectionViewCell {
    static let reuseIdentifer = "category-cell"
    var icon: FontAwesome.Icon {
        get {
            .pizzaSlice
        }
        set {
            iconLabel.attributedText = NSAttributedString.icon(newValue, size: 50, style: .solid)
        }
    }

    var color: UIColor {
        get {
            iconLabel.textColor
        }
        set {
            iconLabel.textColor = newValue
        }
    }

    var title: String {
        get {
            titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }

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
