import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigator: Navigator?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let didTapShowCountStream = PublishSubject<Void>()
        let counterViewController = CounterViewController(didTapShowCountStream: didTapShowCountStream)
        let countViewController = CountViewController()
        let navigationController = UINavigationController(rootViewController: counterViewController)
        
        navigator = Navigator(navigationController: navigationController,
                                  countViewController: countViewController,
                                  didTapShowCountStream: didTapShowCountStream)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        
        return true
    }
}

