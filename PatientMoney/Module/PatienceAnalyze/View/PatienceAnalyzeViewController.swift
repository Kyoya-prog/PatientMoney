import Foundation
import UIKit

class PatienceAnalyzeViewController: UIViewController, PatienceAnalyzeView {
    var records: [PatienceEntity] = [] {
        didSet {
            recordsView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = L10n.PatienceAnalyzeViewController.NavigationItem.title
        presentation.didSelectMonth(year: textField.selectedYear, month: textField.selectedMonth)
        construct()
    }

    private func construct() {
        setUpMonthSelectView()
        monthSelectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(monthSelectView)

        setUpSumView()
        sumView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sumView)

        recordsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordsView)

        NSLayoutConstraint.activate([
            monthSelectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            monthSelectView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            monthSelectView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),

            sumView.topAnchor.constraint(equalTo: monthSelectView.bottomAnchor, constant: 30),
            sumView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            sumView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            sumView.heightAnchor.constraint(equalToConstant: 100),

            recordsView.topAnchor.constraint(equalTo: sumView.bottomAnchor, constant: 30),
            recordsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            recordsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            recordsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setUpMonthSelectView() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.didSelectAction = { [weak self]() in
            guard let self = self else { return }
            self.updateLabel()
            self.presentation.didSelectMonth(year: self.textField.selectedYear, month: self.textField.selectedMonth)
        }
        monthSelectView.addSubview(textField)

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.font = UIFont.systemFont(ofSize: 20)
        monthLabel.text = L10n.PatienceAnalyzeViewController.MonthLabel.text
        monthLabel.setContentHuggingPriority(.required, for: .horizontal)
        monthSelectView.addSubview(monthLabel)

        NSLayoutConstraint.activate([
            monthSelectView.heightAnchor.constraint(equalToConstant: 25),

            monthLabel.centerYAnchor.constraint(equalTo: monthSelectView.centerYAnchor),
            monthLabel.leftAnchor.constraint(equalTo: monthSelectView.leftAnchor),

            textField.centerYAnchor.constraint(equalTo: monthSelectView.centerYAnchor),
            textField.leftAnchor.constraint(equalTo: monthLabel.rightAnchor, constant: 10),
            textField.rightAnchor.constraint(equalTo: monthSelectView.rightAnchor)
        ])
    }

    private func setUpSumView() {
        sumView.layer.borderColor = UIColor(hex: "FFECCC").cgColor
        sumView.layer.borderWidth = 2
        sumView.layer.cornerRadius = 4

        selectedMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedMonthLabel.font = UIFont.boldSystemFont(ofSize: 30)
        selectedMonthLabel.textColor = UIColor(hex: "FFA81C")
        sumView.addSubview(selectedMonthLabel)

        sumMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        sumMoneyLabel.font = UIFont.boldSystemFont(ofSize: 30)
        sumMoneyLabel.textColor = UIColor(hex: "FFA81C")
        sumView.addSubview(sumMoneyLabel)

        updateLabel()

        NSLayoutConstraint.activate([
            selectedMonthLabel.topAnchor.constraint(equalTo: sumView.topAnchor, constant: 10),
            selectedMonthLabel.centerXAnchor.constraint(equalTo: sumView.centerXAnchor),

            sumMoneyLabel.topAnchor.constraint(equalTo: selectedMonthLabel.bottomAnchor, constant: 10),
            sumMoneyLabel.bottomAnchor.constraint(equalTo: sumView.bottomAnchor, constant: -10),
            sumMoneyLabel.rightAnchor.constraint(equalTo: sumView.rightAnchor, constant: -10),
            sumMoneyLabel.leftAnchor.constraint(greaterThanOrEqualTo: sumView.leftAnchor)
        ])
    }

    private func updateLabel() {
        selectedMonthLabel.text = L10n.PatienceAnalyzeViewController.SelectedMonthLabel.text("\(textField.selectedYear)", textField.selectedMonth)
        sumMoneyLabel.text = L10n.PatienceAnalyzeViewController.SumMoneyLabel.text(sumMoney)
    }

    private lazy var recordsView: UITableView = {
        let view = UITableView()
        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseIdentifer)
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = false
        return view
    }()

    private let textField = YearAndMonthDateTextField()

    private let monthLabel = UILabel()

    private let monthSelectView = UIView()

    private let sumView = UIView()

    private let sumMoneyLabel = UILabel()

    private let selectedMonthLabel = UILabel()

    private var sumMoney = 0 {
        didSet {
            sumMoneyLabel.text = "合計\(sumMoney)円"
        }
    }

    // MARK: PatienceAnalyzeView
    var presentation: PatienceAnalyzePresentation!

    func updateRecords(records: [PatienceEntity]) {
        self.records = records
    }

    func updateSumMoney(sumMoney: Int) {
        self.sumMoney = sumMoney
    }

    func showError(message: String) {
        StatusNotification.notifyError(message)
    }
}

extension PatienceAnalyzeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.reuseIdentifer) as! RecordCell
        let record = records[indexPath.item]
        cell.categoryTitle = record.categoryTitle
        cell.money = record.money
        return cell
    }
}
