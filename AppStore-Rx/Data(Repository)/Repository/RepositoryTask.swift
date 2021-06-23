//
//  RepositoryTask.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/24.
//

import Foundation

class RepositoryTask: Cancellable {
	var networkTask: NetworkCancellable?
	var isCancelled: Bool = false

	func cancel() {
		networkTask?.cancel()
		isCancelled = true
	}
}
