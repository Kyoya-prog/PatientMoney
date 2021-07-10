import UIKit

class Category {
    static let categories:[(icon: FontAwesome.Icon, title: String, color: UIColor)] = [
        (icon:.pizzaSlice, title:L10n.CategoryIcon.Title.pizzaSlice, UIColor(hex: "FFA500")),
        (icon:.bus, title:L10n.CategoryIcon.Title.bus, UIColor(hex: "00BFFF")),
        (icon:.beer, title:L10n.CategoryIcon.Title.beer, UIColor(hex: "FFFF00")),
        (icon:.child, title:L10n.CategoryIcon.Title.child, UIColor(hex: "FFA07A")),
        (icon:.tshirt, title:L10n.CategoryIcon.Title.tshirt, UIColor(hex: "425D69")),
        (icon:.paintBrush, title:L10n.CategoryIcon.Title.paintBrush, UIColor(hex: "FF0000"))
    ]
}
