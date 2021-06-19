import Foundation
import UIKit

class PatienceAnalyzeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "EDB077")

        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.distribution = .equalSpacing
        vstack.spacing = 10
        view.addSubview(vstack)

        vstack.addArrangedSubview(textField)
        textField.selectedAction = { date in
            print(date)
        }
        vstack.addArrangedSubview(checkView)
        checkView.didToggleCheckBoxAction = { isOn in
            self.textField.isSingleDaySelect = !isOn
        }
        chart.records = [
            .init(categoryTilte: "飲食費", money: 100),
            .init(categoryTilte: "交通費", money: 200),
            .init(categoryTilte: "飲食費", money: 400),
            .init(categoryTilte: "服代", money: 500),
            .init(categoryTilte: "飲み代", money: 800),
            .init(categoryTilte: "趣味代", money: 280),
            .init(categoryTilte: "交際費", money: 500)
        ]

        vstack.addArrangedSubview(chart)

        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            vstack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            vstack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            vstack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),

            textField.widthAnchor.constraint(equalToConstant: 200),

            chart.widthAnchor.constraint(equalTo: vstack.widthAnchor),
            chart.heightAnchor.constraint(equalTo: vstack.widthAnchor)
        ])
    }

    private let vstack = UIStackView()

    private let textField = SelectableDatePickStyleTextField()

    private let chart = PatienceChartsView()

    private let checkView = DateSelectStyleCheckView()
}
