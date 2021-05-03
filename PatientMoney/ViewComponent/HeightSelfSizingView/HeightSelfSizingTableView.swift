import UIKit

/// コンテンツのサイズで高さが決まるテーブルビュー
open class HeightSelfSizingTableView: UITableView {
    // MARK: - Override
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
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
