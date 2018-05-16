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
            counter = Counter(disposeBag: disposeBag)
        }

        it("starts with 0") {
            expect(counter.countRelay.value).to(equal(0))
        }

        describe("#increment") {
            it("increments the count") {
                counter.increment()
                counter.increment()
                expect(counter.countRelay.value).to(equal(2))
            }
        }

        describe("#decrement") {
            it("decrement the count") {
                counter.decrement()
                counter.decrement()
                counter.decrement()
                expect(counter.countRelay.value).to(equal(-3))
            }
        }
    }
}
