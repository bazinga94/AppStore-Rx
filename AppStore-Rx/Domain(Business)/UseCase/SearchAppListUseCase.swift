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
				 completion: @escaping (Result<AppInfoList, Error>) -> Void) -> Cancellable?
}

class SearchAppListUseCase: SearchAppListUseCaseProtocol {

	private let appInfoListRepository: AppInfoListRepositoryProtocol

	init(appInfoListRepository: AppInfoListRepositoryProtocol) {
		self.appInfoListRepository = appInfoListRepository
	}

	func execute(requestModel: SearchAppListUseCaseRequestModel, completion: @escaping (Result<AppInfoList, Error>) -> Void) -> Cancellable? {
		return appInfoListRepository.fetchAppInfoList(query: AppInfoListQuery(query: requestModel.query), completion: completion)
	}
}
