import Foundation

struct PatienceEntity: Decodable {
    let id: Int
    let registeredAt: Date
    let memo: String
    let money: Int
    let categoryTitle: String

    enum CofingKeys: String, CodingKey {
        case registeredAt = "registered_at"
        case categoryTitle = "category_title"
    }
}
