import UIKit
import RxSwift
import RxCocoa

class CountViewController: UIViewController {
    let counter: Counter
    let disposeBag: DisposeBag
    
    @IBOutlet weak var countLabel: UILabel!
    
    public init(counter: Counter) {
        self.counter = counter
        self.disposeBag = DisposeBag()
        super.init(nibName: "CountView", bundle: Bundle.init(identifier: "com.frs.Counter"))
    }

    override func viewDidLoad() {
        self.counter.countRelay.asObservable()
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
