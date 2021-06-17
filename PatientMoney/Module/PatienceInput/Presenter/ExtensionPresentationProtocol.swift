import Foundation

extension PatienceRegisterPresentation {
    func didTapInputButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        didTapRegisterButton(date: date, memo: memo, money: money, categoryTitle: categoryTitle)
    }
}

extension PatienceUpdatePresentation {
    func didTapInputButton(date: Date, memo: String, money: Int, categoryTitle: String) {
        didTapUpdateButton(date: date, memo: memo, money: money, categoryTitle: categoryTitle)
    }
}
