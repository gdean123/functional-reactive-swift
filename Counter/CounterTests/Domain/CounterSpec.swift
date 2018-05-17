import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Counter

class CounterSpec: QuickSpec {
    override func spec() {
        var counter: Counter!
        var disposeBag: DisposeBag!

        beforeEach {
            disposeBag = DisposeBag()
            counter = Counter(initialCount: 4, disposeBag: disposeBag)
        }

        it("starts with the inital count") {
            expect(counter.countRelay.value).to(equal(4))
        }

        describe("#increment") {
            it("increments the count") {
                counter.increment()
                counter.increment()
                expect(counter.countRelay.value).to(equal(6))
            }
        }

        describe("#decrement") {
            it("decrement the count") {
                counter.decrement()
                counter.decrement()
                counter.decrement()
                expect(counter.countRelay.value).to(equal(1))
            }
        }
    }
}
