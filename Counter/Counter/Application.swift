import UIKit
import RxSwift
import RealmSwift

class Application {
    var window: UIWindow?
    let navigationController: UINavigationController
    let disposeBag: DisposeBag
    let persistCountSink: PersistCountSink

    init() {
        disposeBag = DisposeBag()

        let realm = try! Realm()
        let countSource = PersistedCountSource(realm: realm)

        let didTapShowCountStream = PublishSubject<Void>()
        let counter = Counter(initialCountStream: countSource.initial())

        let counterViewController = CounterViewController(
            counter: counter,
            didTapShowCountStream: didTapShowCountStream,
            disposeBag: disposeBag
        )

        let countViewController = CountViewController(
            count: countSource.all(),
            disposeBag: disposeBag
        )

        navigationController = UINavigationController(rootViewController: counterViewController)

        let _ = Navigator(
            navigationController: navigationController,
            countViewController: countViewController,
            didTapShowCountStream: didTapShowCountStream,
            disposeBag: disposeBag
        )

        persistCountSink = PersistCountSink(realm: realm, count: counter.countStream(), disposeBag: disposeBag)
    }

    func run() {
        persistCountSink.listen()

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}
