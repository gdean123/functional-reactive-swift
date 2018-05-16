import Foundation
import RxSwift
import RxCocoa

class Counter {
    let countRelay: BehaviorRelay<Int>

    private let persistedCountStream: Observable<Int>
    private let didIncrementStream: PublishSubject<Void>
    private let didDecrementStream: PublishSubject<Void>
    private let disposeBag: DisposeBag

    init(persistedCountStream: Observable<Int>, disposeBag: DisposeBag) {
        self.didIncrementStream = PublishSubject()
        self.didDecrementStream = PublishSubject()
        self.persistedCountStream = persistedCountStream
        self.countRelay = BehaviorRelay(value: 0)
        self.disposeBag = disposeBag

        count()
            .bind(to: countRelay)
            .disposed(by: disposeBag)
    }

    func increment() {
        didIncrementStream.onNext(Void())
    }

    func decrement() {
        didDecrementStream.onNext(Void())
    }

    private enum CountEvent {
        case delta(amount: Int)
        case replace(value: Int)
    }

    private func count() -> Observable<Int> {
        return countEvents()
            .scan(0) { accumulator, countEvent in
                switch countEvent {
                case .delta(let amount):
                    return accumulator + amount
                case .replace(let value):
                    return value
                }
            }
            .distinctUntilChanged()
    }

    private func countEvents() -> Observable<CountEvent> {
        return Observable.merge(
            didIncrementStream.map {
                CountEvent.delta(amount: 1)
            },
            didDecrementStream.map {
                CountEvent.delta(amount: -1)
            },
            persistedCountStream.map { persistedCount in
                CountEvent.replace(value: persistedCount)
            }
        )
    }
}
