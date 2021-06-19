//import Foundation
//import UIKit.UIViewController
//
//class PatienceAnalyzeRouter {
//    static func assembleModule() -> UIViewController {
//        let viewController = PatienceAnalyzeViewController()
//        let presenter = PatienceAnalyzePresenter()
//        let interactor = PatienceAnalyzeInteractor()
//        let dataStore = PatienceDataStore()
//
//        presenter.usecase = interactor
//        //presenter.view = viewController
//        interactor.output = presenter
//        interactor.repository = dataStore
//        //viewController.presentation = presenter
//
//        return viewController
//    }
//}
