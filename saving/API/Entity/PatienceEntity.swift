import Foundation

struct PatienceEntity: Decodable {
    let id: Int
    let registeredAt: Date
    let memo: String?
    let money: Int
    let categoryTitle: String

    enum CodingKeys: String, CodingKey {
        case id
        case registeredAt = "registered_at"
        case memo
        case money
        case categoryTitle = "category_title"
    }
}

struct PatiencesEntity: Decodable {
    let patiences: [PatienceEntity]
}
