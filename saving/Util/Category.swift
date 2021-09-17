import UIKit

enum Category: CaseIterable {
    case pizzaSlice
    case bus
    case beer
    case child
    case clothes
    case paintBrush

    var icon: FontAwesome.Icon {
        switch self {
        case .pizzaSlice:
            return .pizzaSlice

        case .bus:
            return .bus

        case .beer:
            return .beer

        case .child:
            return .child

        case .clothes:
            return .tshirt

        case .paintBrush:
            return .paintBrush
        }
    }

    var title: String {
        switch self {
        case .pizzaSlice:
            return L10n.CategoryIcon.Title.pizzaSlice

        case .bus:
            return L10n.CategoryIcon.Title.bus

        case .beer:
            return L10n.CategoryIcon.Title.beer

        case .child:
            return L10n.CategoryIcon.Title.child

        case .clothes:
            return L10n.CategoryIcon.Title.tshirt

        case .paintBrush:
            return L10n.CategoryIcon.Title.paintBrush
        }
    }

    var color: UIColor {
        switch self {
        case .pizzaSlice:
            return UIColor(hex: "FFA500")

        case .bus:
            return UIColor(hex: "00BFFF")

        case .beer:
            return UIColor(hex: "FFFF00")

        case .child:
            return UIColor(hex: "FFA07A")

        case .clothes:
            return UIColor(hex: "425D69")

        case .paintBrush:
            return UIColor(hex: "FF0000")
        }
    }
}
