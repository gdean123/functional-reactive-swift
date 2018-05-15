import UIKit
import RxSwift
import RxCocoa

class CounterViewController: UIViewController {
    let counter: Counter
    let didTapShowCountStream: PublishSubject<Void>
    let disposeBag: DisposeBag
    
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var showCountButton: UIButton!
    
    public init(counter: Counter,
        didTapShowCountStream: PublishSubject<Void>) {
        self.disposeBag = DisposeBag()
        self.counter = counter
        self.didTapShowCountStream = didTapShowCountStream
        
        super.init(nibName: "CounterView", bundle: Bundle.init(identifier: "com.frs.Counter"))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        incrementButton.rx.tap
            .bind(to: counter.didTapIncrementStream)
            .disposed(by: disposeBag)
        
        decrementButton.rx.tap
            .bind(to: counter.didTapDecrementStream)
            .disposed(by: disposeBag)
        
        showCountButton.rx.tap
            .bind(to: didTapShowCountStream)
            .disposed(by: disposeBag)       
    }
}
