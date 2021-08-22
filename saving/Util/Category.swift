import UIKit

enum Category: CaseIterable {
    case pizzaSlice
    case bus
    case beer
    case child
    case tshirt
    case paintBrusy

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

        case .tshirt:
            return .tshirt

        case .paintBrusy:
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

        case .tshirt:
            return L10n.CategoryIcon.Title.tshirt

        case .paintBrusy:
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

        case .tshirt:
            return UIColor(hex: "425D69")

        case .paintBrusy:
            return UIColor(hex: "FF0000")
        }
    }
}
