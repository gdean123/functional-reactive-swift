import UIKit

class CounterViewController: UIViewController {
    public init() {
        super.init(nibName: "CounterView", bundle: Bundle.main)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}