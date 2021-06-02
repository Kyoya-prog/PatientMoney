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

        sumLabel.text = "合計\(sumMoney)円"
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(sumLabel)

        recordsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordsView)

        NSLayoutConstraint.activate([
            monthSelectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            monthSelectView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            monthSelectView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),

            sumLabel.topAnchor.constraint(equalTo: monthSelectView.bottomAnchor, constant: 30),
            sumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            recordsView.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 30),
            recordsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            recordsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            recordsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setUpMonthSelectView() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        monthSelectView.addSubview(textField)

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.font = UIFont.systemFont(ofSize: 20)
        monthLabel.text = "月を入力"
        monthSelectView.addSubview(monthLabel)

        NSLayoutConstraint.activate([
            monthSelectView.heightAnchor.constraint(equalToConstant: 25),

            monthLabel.centerYAnchor.constraint(equalTo: monthSelectView.centerYAnchor),
            monthLabel.leftAnchor.constraint(equalTo: monthSelectView.leftAnchor, constant: 20),

            textField.centerYAnchor.constraint(equalTo: monthSelectView.centerYAnchor),
            textField.leftAnchor.constraint(equalTo: monthSelectView.leftAnchor, constant: 170),
            textField.rightAnchor.constraint(equalTo: monthSelectView.rightAnchor, constant: -20)
        ])
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

    private let sumLabel = UILabel()
    
    private var sumMoney = 0{
        didSet{
            sumLabel.text = "合計\(sumMoney)円"
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
