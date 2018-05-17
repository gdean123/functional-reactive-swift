import UIKit
import RxSwift

class NavigationSink {
    let navigationController: UINavigationController
    let countViewController: CountViewController
    let didTapShowCountStream: Observable<Void>
    let disposeBag = DisposeBag()

    init(navigationController: UINavigationController, countViewController: CountViewController, didTapShowCountStream: Observable<Void>) {
        self.navigationController = navigationController
        self.countViewController = countViewController
        self.didTapShowCountStream = didTapShowCountStream
    }

    func listen() {
        self.didTapShowCountStream
            .subscribe({ _ in self.navigate(to: self.countViewController) })
            .disposed(by: disposeBag)
    }

    private func navigate(to: UIViewController) {
        self.navigationController.pushViewController(to, animated: true)
    }
}
