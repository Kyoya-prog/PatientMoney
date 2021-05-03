import Foundation
import UIKit.UIViewController

class PatienceRegisterRouter: PatienceRegisterWireframe {
    var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let registerView = PatienceRegisterViewController()
        let presenter = PatienceRegisterPresenter()
        let interactor = PatienceRegisterInteractor()
        let datastore = PatienceRegisterDataStore()

        interactor.repository = datastore
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.view = registerView
        registerView.presenter = presenter

        return registerView
    }
}
