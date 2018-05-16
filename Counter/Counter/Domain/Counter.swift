import Foundation
import RxSwift
import RxCocoa

class Counter {
    let countRelay: BehaviorRelay<Int>

    private let didIncrementStream: PublishSubject<Void>
    private let didDecrementStream: PublishSubject<Void>
    private let disposeBag: DisposeBag

    init(disposeBag: DisposeBag) {
        self.didIncrementStream = PublishSubject<Void>()
        self.didDecrementStream = PublishSubject<Void>()
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

    private func count() -> Observable<Int> {
        return Observable.merge(self.didIncrementStream.map { 1 }, self.didDecrementStream.map { -1 })
            .scan(0) {(accumulator, currentValue) in accumulator + currentValue }
    }
}
