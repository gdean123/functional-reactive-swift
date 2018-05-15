import UIKit
import RxSwift

class Navigator {
    let navigationController: UINavigationController
    let countViewController: CountViewController
    
    init(navigationController: UINavigationController, countViewController: CountViewController, didTapShowCountStream: PublishSubject<Void>) {
        self.navigationController = navigationController
        self.countViewController = countViewController
        
        let _ = didTapShowCountStream.subscribe({ _ in
            self.navigationController.pushViewController(countViewController, animated: true)
        })
    }
}
