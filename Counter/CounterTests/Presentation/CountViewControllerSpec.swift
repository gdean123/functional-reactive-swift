import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Counter

class CountViewControllerSpec: QuickSpec {
    override func spec() {
        var countViewController: CountViewController!
        var counter: Counter!

        beforeEach {
            counter = Counter()
            countViewController = CountViewController(counter: counter)
            let _ = countViewController.view
        }

        it("does not render the count initially") {
            expect(countViewController.countLabel.text).to(equal(""))
        }

        describe("when a count is emitted") {
            it("renders the count") {
                counter.increment()
                counter.increment()
                expect(countViewController.countLabel.text).to(equal("2"))
            }
        }
    }
}
