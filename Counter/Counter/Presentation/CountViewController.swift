import UIKit
import RxSwift
import RxCocoa

class CountViewController: UIViewController {
    let count: Observable<Int>
    let disposeBag: DisposeBag
    
    @IBOutlet weak var countLabel: UILabel!
    
    public init(count: Observable<Int>, disposeBag: DisposeBag) {
        self.count = count
        self.disposeBag = disposeBag
        super.init(nibName: "CountView", bundle: Bundle.init(identifier: "com.frs.Counter"))
    }

    override func viewDidLoad() {
        self.count
            .map({count in String(count) })
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
