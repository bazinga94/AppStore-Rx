//
//  SearchAppListRepository.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

protocol AppInfoListRepository {
	func fetchAppInfoList(query: AppInfoListQuery,
						  completion: (Result<AppInfoList, Error>) -> Void) -> Cancellable?
}
