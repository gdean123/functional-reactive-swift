import Foundation
import RxSwift
import RxCocoa

class Counter {
    let countRelay: BehaviorRelay<Int>

    private let didIncrementStream: PublishSubject<Void>
    private let didDecrementStream: PublishSubject<Void>
    private let disposeBag: DisposeBag

    init(initialCount: Int, disposeBag: DisposeBag) {
        self.didIncrementStream = PublishSubject()
        self.didDecrementStream = PublishSubject()
        self.countRelay = BehaviorRelay(value: initialCount)
        self.disposeBag = disposeBag

        count(initialCount: initialCount)
            .bind(to: countRelay)
            .disposed(by: disposeBag)
    }

    func increment() {
        didIncrementStream.onNext(Void())
    }

    func decrement() {
        didDecrementStream.onNext(Void())
    }

    private func count(initialCount: Int) -> Observable<Int> {
        return countEvents()
            .scan(initialCount) { accumulator, currentValue in
                return accumulator + currentValue
            }
    }

    private func countEvents() -> Observable<Int> {
        return Observable.merge(
            didIncrementStream.map { 1 },
            didDecrementStream.map { -1 }
        )
    }
}
