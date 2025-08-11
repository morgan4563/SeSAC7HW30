//
//  Observable.swift
//  MVVMBasic
//
//  Created by hyunMac on 8/11/25.
//

import Foundation

final class Observable<T> {
    private var closure: ((T) -> Void)?

    var value: T {
        didSet {
            closure?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(closure: @escaping (T) -> Void) {
        self.closure = closure
        closure(value)
    }
}
