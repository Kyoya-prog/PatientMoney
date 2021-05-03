import Foundation
import UIKit.UIViewController

class PatienceInputRouter: PatienceInputWireframe {
    
    var viewController: UIViewController?

    static func assembleRegisterModule() -> UIViewController {
        let registerView = PatienceInputViewController(isNewRecord: true)
        let presenter = PatienceInputPresenter()
        let interactor = PatienceInteractor()
        let datastore = PatienceDataStore()

        interactor.repository = datastore
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.view = registerView
        registerView.presenter = presenter

        return registerView
    }
    
    static func assembleUpdateModule(record:PatienceRecord) ->UIViewController{
        let registerView = PatienceInputViewController(isNewRecord: false)
        let presenter = PatienceInputPresenter()
        let interactor = PatienceInteractor()
        let datastore = PatienceDataStore()
        
        registerView.dateRecord = record.date
        registerView.memoRecord = record.description
        registerView.moneyRecord = record.money
        registerView.categoryTitleRecord = record.categoryTitle
        presenter.documentId = record.documentID

        interactor.repository = datastore
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.view = registerView
        registerView.presenter = presenter

        return registerView
    }
    
    func presentInputViewController(){
        
    }
}
