import UIKit.NSAttributedString

extension NSAttributedString {
    static func icon(_ icon: FontAwesome.Icon, size: CGFloat, style: FontAwesome.Style = .solid) -> NSAttributedString {
        NSAttributedString(string: icon.code, attributes: [
                .font: FontAwesome.font(size: size, style: style)
        ]
        )
    }
}
