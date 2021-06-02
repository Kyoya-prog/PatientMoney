import Foundation
import UIKit

class PatienceAnalyzeViewController: UIViewController {
    var records: [PatienceEntity] = [] {
        didSet {
            recordsView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(vstack)

        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vstack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            vstack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            vstack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func construct() {
        vstack.addArrangedSubview(textField)
        vstack.addArrangedSubview(recordsView)
    }

    private lazy var vstack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        return view
    }()

    private lazy var recordsView: UITableView = {
        let view = UITableView()
        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseIdentifer)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private let textField = YearAndMonthDateTextField()
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
