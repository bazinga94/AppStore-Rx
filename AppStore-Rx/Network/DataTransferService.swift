//
//  DataTransferService.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

public protocol Cancellable {
	func cancel()
}

protocol DataTransferService {
}

class SearchAppDataTransferService: DataTransferService {
}
