import UIKit
import RxSwift
import RealmSwift

class Application {
    var window: UIWindow?
    let navigationController: UINavigationController
    let disposeBag: DisposeBag

    init() {
        disposeBag = DisposeBag()

        let realm = try! Realm()
        let countRepository = CountRepository(realm: realm, disposeBag: disposeBag)

        let didTapShowCountStream = PublishSubject<Void>()
        let counter = Counter(disposeBag: disposeBag)

        countRepository.update(count: counter.countRelay.asObservable())

        let counterViewController = CounterViewController(
            counter: counter,
            didTapShowCountStream: didTapShowCountStream,
            disposeBag: disposeBag
        )

        let countViewController = CountViewController(
            count: countRepository.get(),
            disposeBag: disposeBag
        )

        navigationController = UINavigationController(rootViewController: counterViewController)

        let _ = Navigator(
            navigationController: navigationController,
            countViewController: countViewController,
            didTapShowCountStream: didTapShowCountStream,
            disposeBag: disposeBag
        )
    }

    func run() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}
