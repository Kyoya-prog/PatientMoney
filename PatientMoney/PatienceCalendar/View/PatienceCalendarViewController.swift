import Foundation
import FSCalendar
import UIKit

struct PatienceRecord {
    var documentID: String
    var date: Date
    var description: String
    var money: Int
    var categoryTitle: String
}

class PatienceCalenderViewController: UIViewController {
    var records: [PatienceRecord] = []{
        didSet{
            recordsView.reloadData()
        }
    }
    
    var date = Date(){
        didSet{
            recordsView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.delegate = self
        calendar.dataSource = self
        view.addSubview(calendar)

        recordsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordsView)

        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendar.heightAnchor.constraint(equalToConstant: view.frame.height * 0.4),
            calendar.widthAnchor.constraint(equalToConstant: view.frame.width),

            recordsView.topAnchor.constraint(equalTo: calendar.bottomAnchor),
            recordsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordsView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            recordsView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }

    let calendar = FSCalendar()

    private lazy var recordsView: HeightSelfSizingTableView = {
        let view = HeightSelfSizingTableView()
        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseIdentifer)
        view.delegate = self
        view.dataSource = self
        return view
    }()
}

extension PatienceCalenderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        DateUtils.stringFromDate(date: Date(), format: "yyyy年MM月dd日")
    }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PatienceCalenderViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = date
    }
}

private class RecordCell: UITableViewCell {
    var categoryTitle = ""{
        didSet {
            updateValue()
        }
    }

    var money = 0 {
        didSet {
            updateValue()
        }
    }

    static let reuseIdentifer = "patience-record"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        construct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }

    private func construct() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(icon)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(moneyLabel)

        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor),

            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5),

            moneyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moneyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3),
            moneyLabel.leftAnchor.constraint(greaterThanOrEqualTo: titleLabel.rightAnchor)
        ])
    }

    private let icon = UILabel()

    private let titleLabel = UILabel()

    private let moneyLabel = UILabel()

    private func updateValue() {
        let category = Category.categories.filter {
            $0.title == categoryTitle
        }
        icon.attributedText = NSAttributedString.icon(category[0].icon, size: 20, style: .solid)
        icon.textColor = category[0].color

        titleLabel.text = category[0].title

        moneyLabel.text = String(money) + "円"
    }
}
