import UIKit
import RxSwift

class Application {
    var window: UIWindow?
    let navigator: Navigator
    let navigationController: UINavigationController
    
    init() {
        let didTapShowCountStream = PublishSubject<Void>()
        let counterViewController = CounterViewController(didTapShowCountStream: didTapShowCountStream)
        let countViewController = CountViewController()
        navigationController = UINavigationController(rootViewController: counterViewController)
        
        navigator = Navigator(navigationController: navigationController,
                              countViewController: countViewController,
                              didTapShowCountStream: didTapShowCountStream)
    }
    
    func run() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}
