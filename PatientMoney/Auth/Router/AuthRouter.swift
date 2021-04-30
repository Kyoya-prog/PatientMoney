import Foundation
import UIKit

class AuthRouter:AuthWireFrame{
    var viewController: UIViewController?
    
    func presentSignUpView() {
        let viewController = SignUpViewController()
        // presenterの初期化
        // 依存性注入
        viewController.modalPresentationStyle = .fullScreen
        viewController.present(viewController, animated: true, completion: nil)
    }
    
    func presentSignInView() {
        let viewController = SignInViewController()
        // presenterの初期化
        // 依存性注入
        viewController.modalPresentationStyle = .fullScreen
        viewController.present(viewController, animated: true, completion: nil)
    }
    
    func presentHomeView() {
        print("homeview")
    }
    
    
}
