import Foundation
import UIKit.UIViewController

class PatienceInputRouter: PatienceInputWireframe {
    var viewController: UIViewController?

    static func assembleRegisterModule(date: Date? = nil) -> UIViewController {
        let registerView = PatienceInputViewController(isNewRecord: true)
        let presenter = PatienceInputPresenter()
        let interactor = PatienceInputInteractor()
        let datastore = PatienceDataStore()
        let router = PatienceInputRouter()

        registerView.dateRecord = date ?? Date()

        interactor.repository = datastore
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.view = registerView
        router.viewController = registerView
        presenter.router = router
        registerView.presenter = presenter

        return registerView
    }

    static func assembleUpdateModule(record: PatienceEntity) -> UIViewController {
        let registerView = PatienceInputViewController(isNewRecord: false)
        let presenter = PatienceUpdatePreseneter()
        let interactor = PatienceInputInteractor()
        let datastore = PatienceDataStore()
        let router = PatienceInputRouter()

        registerView.dateRecord = record.date
        registerView.memoRecord = record.memo
        registerView.moneyRecord = record.money
        registerView.categoryTitleRecord = record.categoryTitle
        presenter.documentId = record.documentID

        interactor.repository = datastore
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.view = registerView
        presenter.router = router
        router.viewController = registerView
        registerView.presenter = presenter

        return registerView
    }

    func closeInputView() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func dismissInputModal() {
        viewController?.dismiss(animated: true, completion: nil)
        guard let presentationController = viewController?.presentationController else {
            return
        }
        // dismissで閉じた場合にはADaptivePresentationControllerDelegateのdelegateメソッドが起動しないのでここで明示的に呼んでいる
        viewController?.presentationController?.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
