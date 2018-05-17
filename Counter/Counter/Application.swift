import UIKit
import RxSwift
import RealmSwift

class Application {
    var window: UIWindow?
    let navigationController: UINavigationController
    let persistCountSink: PersistCountSink
    let navigationSink: NavigationSink

    init() {
        let realm = try! Realm()
        let countSource = PersistedCountSource(realm: realm)

        let didTapShowCountStream = PublishSubject<Void>()
        let counter = Counter(initialCountStream: countSource.initial())

        let counterViewController = CounterViewController(
            counter: counter,
            didTapShowCountStream: didTapShowCountStream
        )

        let countViewController = CountViewController(count: countSource.all())

        navigationController = UINavigationController(rootViewController: counterViewController)

        navigationSink = NavigationSink(
            navigationController: navigationController,
            countViewController: countViewController,
            didTapShowCountStream: didTapShowCountStream
        )

        persistCountSink = PersistCountSink(realm: realm, count: counter.countStream())
    }

    func run() {
        persistCountSink.listen()
        navigationSink.listen()

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}
