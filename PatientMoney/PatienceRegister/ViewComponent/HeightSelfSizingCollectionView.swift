import UIKit

/// コンテンツのサイズで高さが決まるコレクションビュー
open class HeightSelfSizingCollectionView: UICollectionView {
    // MARK: - Override
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        construct()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    override public var contentSize: CGSize {
        didSet { invalidateIntrinsicContentSize() }
    }

    override public var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

    // MARK: - Private

    private func construct() {
        isScrollEnabled = false
        setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
