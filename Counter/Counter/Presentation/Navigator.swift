import UIKit
import RxSwift

class Navigator {
    let navigationController: UINavigationController
    let countViewController: CountViewController
    let didTapShowCountStream: Observable<Void>
    let disposeBag: DisposeBag

    init(navigationController: UINavigationController, countViewController: CountViewController, didTapShowCountStream: Observable<Void>, disposeBag: DisposeBag) {
        self.navigationController = navigationController
        self.countViewController = countViewController
        self.didTapShowCountStream = didTapShowCountStream
        self.disposeBag = disposeBag
        
        navigate()
    }

    func navigate() {
        self.didTapShowCountStream
            .subscribe({ _ in
                self.navigationController.pushViewController(self.countViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
