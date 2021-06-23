//
//  SearchAppListRepository.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

protocol AppInfoListRepositoryProtocol {
	func fetchAppInfoList(query: AppInfoListQuery,
						  completion: (Result<AppInfoList, Error>) -> Void) -> Cancellable?
}

class AppInfoListRepository: AppInfoListRepositoryProtocol {

	private let dataTransferService: DataTransferService

	init(dataTransferService: DataTransferService) {
		self.dataTransferService = dataTransferService
	}

	func fetchAppInfoList(query: AppInfoListQuery, completion: (Result<AppInfoList, Error>) -> Void) -> Cancellable? {
		return fetch
	}
}
