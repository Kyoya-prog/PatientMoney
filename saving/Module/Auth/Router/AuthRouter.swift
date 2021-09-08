import Foundation
import UIKit

class AuthRouter {
    var viewController: UIViewController?

    static func assembleHomeModule() -> UIViewController {
        let homeViewController = UITabBarController()
        let inputVC = UINavigationController(rootViewController: PatienceInputRouter.assembleRegisterModule())
        inputVC.tabBarItem = UITabBarItem(title: L10n.AppDelegate.HomeView.RegisterView.title, image: Asset.pen.image, selectedImage: nil)
        homeViewController.addChild(inputVC)
        let calendarVC = UINavigationController(rootViewController: PatienceCalendarRouter.assembleModule())
        calendarVC.tabBarItem = UITabBarItem(title: L10n.AppDelegate.HomeView.CalendarView.title, image: Asset.calendar.image, selectedImage: nil)
        homeViewController.addChild(calendarVC)
        let analyzeVC = UINavigationController(rootViewController: PatienceAnalyzeRouter.assembleModule())
        analyzeVC.tabBarItem = UITabBarItem(title: L10n.AppDelegate.HomeView.AnalyzeView.title, image: Asset.analyze.image, selectedImage: nil)
        homeViewController.addChild(analyzeVC)
        return homeViewController
    }

    func presentHomeView() {
        let homeView = AuthRouter.assembleHomeModule()
        homeView.modalPresentationStyle = .fullScreen
        viewController?.present(homeView, animated: true, completion: nil)
    }
}
