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

protocol SearchAppListUseCase {
	func execute(requestModel: SearchAppListUseCaseRequestModel,
				 completion: (Result<AppInfoList, Error>) -> Void) -> Cancellable?
}
