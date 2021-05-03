import Foundation
import UIKit

class PatienceInputViewController: UIViewController, PatienceInputView {
    var isNewRecord: Bool

    init(isNewRecord: Bool) {
        self.isNewRecord = isNewRecord
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.isNewRecord = false
        super.init(coder: coder)
    }

    var documentId: String = ""

    var dateRecord: Date {
        get {
            (subViews[0] as? DateView)?.selectedDate ?? Date()
        }
        set {
            (subViews[0] as? DateView)?.selectedDate = newValue
        }
    }

    var memoRecord: String {
        get {
            (subViews[1] as? DescriptionView)?.memo ?? ""
        }
        set {
            (subViews[1] as? DescriptionView)?.memo = newValue
        }
    }

    var moneyRecord: Int? {
        get {
            (subViews[2] as? MoneyView)?.money
        }
        set {
            (subViews[2] as? MoneyView)?.money = newValue
        }
    }

    var categoryTitleRecord: String {
        get {
            (subViews[3] as? CategoriesView)?.selectedCategoryTitle ?? ""
        }
        set {
            (subViews[3] as? CategoriesView)?.selectedCategoryTitle = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = L10n.PatienceInputViewController.NavigationItem.title
        view.backgroundColor = .white
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.alignment = .fill
        vstack.distribution = .equalSpacing
        subViews.forEach {
            vstack.addArrangedSubview($0)
            let border = UIView()
            border.backgroundColor = UIColor(hex: "DCDCDC")
            border.heightAnchor.constraint(equalToConstant: 1).isActive = true
            vstack.addArrangedSubview(border)
        }
        view.addSubview(vstack)

        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle(isNewRecord ? L10n.PatienceInputViewController.InputButton.Register.title : L10n.PatienceInputViewController.InputButton.Update.title, for: .normal)
        registerButton.backgroundColor = .orange
        registerButton.layer.cornerRadius = 10
        registerButton.addTarget(self, action: #selector(inputButtonAction(_:)), for: .touchUpInside)
        view.addSubview(registerButton)

        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            vstack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            vstack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            vstack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),

            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            registerButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

    // MARK: RegisterView
    var presenter: PatienceInputPresentation!

    func showError(message: String) {
        StatusNotification.notifyError(message)
    }

    func showSuccess(message: String) {
        StatusNotification.notifySuccess(message)
    }

    // MARK: Private

    private let vstack = UIStackView()

    private let subViews = [
        DateView(),
        DescriptionView(),
        MoneyView(),
        CategoriesView()
    ]

    private let registerButton = UIButton()

    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: L10n.PatienceInputViewController.Alert.title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.PatienceInputViewController.Alert.OkAction.title, style: .default, handler: { [weak self] _ in
            self?.inputAction()
        })
        let cancelAction = UIAlertAction(title: L10n.PatienceInputViewController.Alert.CancelAction.title, style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
    }()

    private func inputAction() {
        if isNewRecord {
            presenter.didTapRegisterButton(patience: Patience(date: dateRecord, description: memoRecord, money: moneyRecord ?? 0, category: categoryTitleRecord))
        } else {
            presenter.didTapUpdateButton(patience: Patience(date: dateRecord, description: memoRecord, money: moneyRecord ?? 0, category: categoryTitleRecord))
        }
    }

    @objc private func inputButtonAction(_ :UIButton) {
        if let money = (subViews[2] as? MoneyView)?.money {
            let patience = Patience(date: dateRecord, description: memoRecord, money: money, category: categoryTitleRecord)
            presenter.didTapRegisterButton(patience: patience)
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
}
