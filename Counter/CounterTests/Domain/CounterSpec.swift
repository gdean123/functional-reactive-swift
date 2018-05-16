import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Counter

class CounterSpec: QuickSpec {
    override func spec() {
        var counter: Counter!
        var persistedCount: PublishSubject<Int>!
        var disposeBag: DisposeBag!

        beforeEach {
            persistedCount = PublishSubject()
            disposeBag = DisposeBag()

            counter = Counter(persistedCountStream: persistedCount, disposeBag: disposeBag)
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

        context("when a persisted count is emitted") {
            it("resets the counter to that value") {
                counter.increment()
                expect(counter.countRelay.value).to(equal(1))

                persistedCount.onNext(10)
                expect(counter.countRelay.value).to(equal(10))

                counter.increment()
                expect(counter.countRelay.value).to(equal(11))
            }
        }

        it("only emits when the value has changed") {
            var numberOfEvents = 0
            counter.countRelay
                .bind(onNext: { count in
                    numberOfEvents += 1
                })
                .disposed(by: disposeBag)

            expect(numberOfEvents).to(equal(1))
            persistedCount.onNext(10)
            persistedCount.onNext(10)
            persistedCount.onNext(10)
            expect(numberOfEvents).to(equal(2))
        }
    }
}
