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
        var disposeBag: DisposeBag!
        var emittedCount: Int!

        beforeEach {
            disposeBag = DisposeBag()
            counter = Counter(initialCountStream: Observable.just(12))
            didTapCountStream = PublishSubject()
            counterViewController = CounterViewController(counter: counter, didTapShowCountStream: didTapCountStream, disposeBag: disposeBag)

            let _ = counterViewController.view

            emittedCount = 0
            counter.countStream().subscribe(onNext: { count in
                emittedCount = count
            }).disposed(by: disposeBag)
        }

        describe("tapping increment") {
            it("increments the count") {
                counterViewController.incrementButton.sendActions(for: .touchUpInside)
                counterViewController.incrementButton.sendActions(for: .touchUpInside)
                expect(emittedCount).to(equal(14))
            }
        }

        describe("tapping decrement") {
            it("decrements the count") {
                counterViewController.decrementButton.sendActions(for: .touchUpInside)
                expect(emittedCount).to(equal(11))
            }
        }
    }
}
