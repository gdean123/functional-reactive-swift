import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Counter

class CounterViewControllerSpec: QuickSpec {
    override func spec() {
        var counterViewController: CounterViewController!
        var counter: Counter!
        var didTapCountStream: PublishSubject<Void>!

        beforeEach {
            counter = Counter()
            didTapCountStream = PublishSubject()
            counterViewController = CounterViewController(counter: counter, didTapShowCountStream: didTapCountStream)

            let _ = counterViewController.view
        }

        describe("tapping increment") {
            it("increments the count") {
                counterViewController.incrementButton.sendActions(for: .touchUpInside)
                counterViewController.incrementButton.sendActions(for: .touchUpInside)
                expect(counter.countRelay.value).to(equal("2"))
            }
        }
    }
}
