import Foundation
import UIKit

class PatienceAnalyzeViewController: UIViewController,PatienceAnalyzeView {
    var presentation: PatienceAnalyzePresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentation.didLoad()
        view.backgroundColor = UIColor(hex: "EDB077")

        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.distribution = .equalSpacing
        vstack.spacing = 10
        view.addSubview(vstack)

        vstack.addArrangedSubview(textField)
        textField.selectedAction = {[weak self] date in
            guard let self = self else { return }
            self.presentation.didChangeDate(dateModel: self.textField.selectedDate, isSelectByMonthAndYear: self.checkView.isChecked)
        }
        vstack.addArrangedSubview(checkView)
        checkView.didToggleCheckBoxAction = { isOn in
            self.textField.isSingleDaySelect = !isOn
        }

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
    
    // MARK: PatienceAnalyticsView
    func updateCharts(data: [PatienceChartDataModel]) {
        presentation.didChangeDate(dateModel: textField.selectedDate, isSelectByMonthAndYear: !checkView.isChecked)
    }
    
    func showError(message: String) {
        StatusNotification.notifyError(message)
    }
}
