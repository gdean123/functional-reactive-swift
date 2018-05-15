import UIKit
import RxSwift

class Application {
    var window: UIWindow?
    let navigator: Navigator
    let navigationController: UINavigationController
    let counter: Counter

    init() {
        let didTapShowCountStream = PublishSubject<Void>()
        counter = Counter()

        let counterViewController = CounterViewController(
            counter: counter,
            didTapShowCountStream: didTapShowCountStream
        )

        let countViewController = CountViewController(counter: counter)
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
