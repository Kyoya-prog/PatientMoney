import Foundation
import FSCalendar
import UIKit

class PatienceCalenderViewController: UIViewController, PatienceCalendarView {
    var records: [PatienceEntity] = [] {
        didSet {
            recordsView.reloadData()
        }
    }

    var date = DateUtils.getStartDay(date: Date()) {
        didSet {
            presenter.selectedDateDidChange(date: date)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.pen.image, style: .plain, target: self, action: #selector(didTapRegisterButton(_:)))
        navigationItem.title = L10n.PatienceCalendarViewController.NavigationItem.title
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
            recordsView.widthAnchor.constraint(equalToConstant: view.frame.width),
            recordsView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.4 )
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.selectedDateDidChange(date: date)
    }

    // MARK: PatienceCalendarView
    var presenter: PatienceCalendarPresentation!

    func showError(message: String) {
        StatusNotification.notifyError(message)
    }

    func showSuccess(message: String) {
        StatusNotification.notifySuccess(message)
    }

    func updateRecord(records: [PatienceEntity]) {
        self.records = records
    }

    func didDeleteRecord() {
        records.remove(at: willDeleteRowValue)
    }

    // MARK: Private

    private let calendar = FSCalendar()

    private let recordListHeaderView = RecordListHeaderView()

    private var willDeleteRowValue: Int = 0

    private lazy var recordsView: UITableView = {
        let view = UITableView()
        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseIdentifer)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    @objc private func didTapRegisterButton(_ sender: UIBarButtonItem) {
        presenter.didTapRegisterButton(date: date)
    }

    private func updateRecordsView() {
        presenter.selectedDateDidChange(date: date)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension PatienceCalenderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            willDeleteRowValue = indexPath.item
            let documentId = records[indexPath.item].documentID
            presenter.didTapDeleteButton(documentId: documentId)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        recordListHeaderView.title = DateUtils.stringFromDate(date: date, format: DateUtils.dateFormatJapanese)
        return recordListHeaderView
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        DateUtils.stringFromDate(date: Date(), format: DateUtils.dateFormatJapanese)
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
        let record = records[indexPath.item]
        presenter.didTapRecordCell(record: record)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: FSCalendarDelegate, FSCalendarDataSource
extension PatienceCalenderViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = DateUtils.getStartDay(date: date)
        recordListHeaderView.title = DateUtils.stringFromDate(date: date, format: DateUtils.dateFormatJapanese)
    }
}

extension PatienceCalenderViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        updateRecordsView()
    }
}
