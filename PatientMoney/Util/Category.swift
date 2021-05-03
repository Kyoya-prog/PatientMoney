import UIKit

class Category {
    static let categories:[(icon: FontAwesome.Icon, title: String, color: UIColor)] = [
        (icon:.pizzaSlice, title:L10n.CategoriesView.IconTitle.pizzaSlice, UIColor(hex: "FFA500")),
        (icon:.bus, title:L10n.CategoriesView.IconTitle.bus, UIColor(hex: "00BFFF")),
        (icon:.paintBrush, title:L10n.CategoriesView.IconTitle.paintBrush, UIColor(hex: "00FF00"))
    ]
}
