import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Counter

class CounterSpec: QuickSpec {
    override func spec() {
        var counter: Counter!

        beforeEach {
            counter = Counter()
        }

        describe("#increment") {
            it("increments the count") {
                counter.increment()
                counter.increment()
                expect(counter.countRelay.value).to(equal("2"))
            }
        }

        describe("#decrement") {
            it("decrement the count") {
                counter.decrement()
                counter.decrement()
                counter.decrement()
                expect(counter.countRelay.value).to(equal("-3"))
            }
        }
    }
}
