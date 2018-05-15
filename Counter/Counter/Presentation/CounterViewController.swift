import UIKit
import RxSwift

class CounterViewController: UIViewController {
    let didTapShowCountStream: PublishSubject<Void>

    public init(didTapShowCountStream: PublishSubject<Void>) {
        self.didTapShowCountStream = didTapShowCountStream
        super.init(nibName: "CounterView", bundle: Bundle.main)
    }
   
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func showCount(_ sender: Any) {
        self.didTapShowCountStream.onNext(Void())
    }
}
