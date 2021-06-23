//
//  SearchAppListUseCase.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

struct SearchAppListUseCaseRequestModel {
	var query: String
}

protocol SearchAppListUseCaseProtocol {
	func execute(requestModel: SearchAppListUseCaseRequestModel,
				 completion: (Result<AppInfoList, Error>) -> Void) -> Cancellable?
}

class SearchAppListUseCase: SearchAppListUseCaseProtocol {

	private let appInfoListRepository: AppInfoListRepository

	init(appInfoListRepository: AppInfoListRepository) {
		self.appInfoListRepository = appInfoListRepository
	}

	func execute(requestModel: SearchAppListUseCaseRequestModel, completion: (Result<AppInfoList, Error>) -> Void) -> Cancellable? {
		return appInfoListRepository.fetchAppInfoList(query: AppInfoListQuery(query: requestModel.query), completion: completion)
	}
}
