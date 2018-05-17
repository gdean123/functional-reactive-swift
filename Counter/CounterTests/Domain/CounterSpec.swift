import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Counter

class CounterSpec: QuickSpec {
    override func spec() {
        var counter: Counter!

        var initialCountStream: PublishSubject<Int>!
        var emittedCount: Int!
        var disposeBag: DisposeBag!

        beforeEach {
            initialCountStream = PublishSubject()
            disposeBag = DisposeBag()
            counter = Counter(initialCountStream: initialCountStream)

            emittedCount = 0
            counter.countStream().subscribe(onNext: { count in
                emittedCount = count
            }).disposed(by: disposeBag)
        }

        context("when an initial count is emitted") {
            beforeEach {
                initialCountStream.onNext(12)
            }

            it("emits that initial count") {
                expect(emittedCount).to(equal(12))
            }

            describe("#increment") {
                it("increments the count") {
                    counter.increment()
                    counter.increment()
                    expect(emittedCount).to(equal(14))
                }
            }

            describe("#decrement") {
                it("decrement the count") {
                    counter.decrement()
                    counter.decrement()
                    counter.decrement()
                    expect(emittedCount).to(equal(9))
                }
            }
        }
    }
}
