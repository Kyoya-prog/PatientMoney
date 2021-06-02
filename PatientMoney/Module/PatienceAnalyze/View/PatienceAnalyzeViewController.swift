import Foundation
import UIKit

class PatienceAnalyzeViewController: UIViewController {
    var records: [PatienceEntity] = [.init(documentID: "2", date: Date(), memo: "test", money: 200, categoryTitle: "服代")] {
        didSet {
            recordsView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

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
        textField.didSelectAction = { () in
            self.updateLabel()
        }
        monthSelectView.addSubview(textField)

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.font = UIFont.systemFont(ofSize: 20)
        monthLabel.text = "表示する年月"
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
        selectedMonthLabel.text = "\(textField.selectedYear)年\(textField.selectedMonth)月の節約合計額"
        sumMoneyLabel.text = "　\(sumMoney)円"
    }

    private lazy var recordsView: UITableView = {
        let view = UITableView()
        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseIdentifer)
        view.delegate = self
        view.dataSource = self
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
