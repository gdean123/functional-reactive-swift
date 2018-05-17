import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Counter

class CountViewControllerSpec: QuickSpec {
    override func spec() {
        var countViewController: CountViewController!
        var count: PublishSubject<Int>!

        beforeEach {
            count = PublishSubject()
            countViewController = CountViewController(count: count)
            let _ = countViewController.view
        }

        describe("when a count is emitted") {
            it("renders the count") {
                count.onNext(123)
                expect(countViewController.countLabel.text).to(equal("123"))
            }
        }
    }
}
