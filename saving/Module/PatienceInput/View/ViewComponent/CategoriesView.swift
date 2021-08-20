import Foundation
import UIKit

/// カテゴリーView
class CategoriesView: UIView {
    /// 選択されたカテゴリータイトル
    var selectedCategoryTitle: String = L10n.CategoryIcon.Title.pizzaSlice {
        didSet {
            categoriesView.reloadData()
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
        categoriesView.backgroundColor = UIColor(hex: "FFDAA5")
        categoriesView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoriesView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
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
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifer)
        return view
    }()

    private let titleLabel = UILabel()
}

// MARK: CollectionViewDelegateMethod
extension CategoriesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Category.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10
        let height = CGFloat(80)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifer, for: indexPath) as! CategoryCell
        let category = Category.categories[indexPath.item]
        cell.icon = category.icon
        cell.title = category.title
        cell.color = category.color
        cell.isSelectedCell = category.title == selectedCategoryTitle
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Category.categories[indexPath.item]
        selectedCategoryTitle = category.title
        categoriesView.reloadData()
    }
}
