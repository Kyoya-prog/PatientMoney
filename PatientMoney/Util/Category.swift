import UIKit

class Category {
    static let categories:[(icon: FontAwesome.Icon, title: String, color: UIColor)] = [
        (icon:.pizzaSlice, title:L10n.CategoryIcon.Title.pizzaSlice, UIColor(hex: "FFA500")),
        (icon:.bus, title:L10n.CategoryIcon.Title.bus, UIColor(hex: "00BFFF")),
        (icon:.paintBrush, title:L10n.CategoryIcon.Title.paintBrush, UIColor(hex: "00FF00"))
    ]
}
