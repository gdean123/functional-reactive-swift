import UIKit

class CountViewController: UIViewController {
    public init() {
        super.init(nibName: "CountView", bundle: Bundle.main)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
