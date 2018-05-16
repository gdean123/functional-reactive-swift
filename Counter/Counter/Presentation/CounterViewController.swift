import UIKit
import RxSwift
import RxCocoa

class CounterViewController: UIViewController {
    let counter: Counter
    let didTapShowCountStream: PublishSubject<Void>
    let disposeBag: DisposeBag
    
    @IBOutlet weak var showCountButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!

    public init(counter: Counter, didTapShowCountStream: PublishSubject<Void>) {
        self.disposeBag = DisposeBag()
        self.counter = counter
        self.didTapShowCountStream = didTapShowCountStream
        
        super.init(nibName: "CounterView", bundle: Bundle.init(identifier: "com.frs.Counter"))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func didTapDecrement(_ sender: Any) {
        counter.decrement()
    }

    @IBAction func didTapIncrement(_ sender: Any) {
        counter.increment()
    }

    override func viewDidLoad() {
        showCountButton.rx.tap
            .bind(to: didTapShowCountStream)
            .disposed(by: disposeBag)
    }
}
