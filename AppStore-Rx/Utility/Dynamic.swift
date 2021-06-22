//
//  Dynamic.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

class Dynamic<T> {
	typealias Listener = (T) -> Void
	var listener: Listener?

	var value: T {
		didSet {
			listener?(value)
		}
	}

	init(_ value: T) {
		self.value = value
	}

	func bind(listener: Listener?) {
		self.listener = listener
		listener?(value)
	}
}
// RxSwift로 수정하기 전에 임시로...
