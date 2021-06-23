//
//  SearchAppListViewModel.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation
import RxSwift

protocol SearchAppListViewModelInput {
	func viewDidLoad()
	func didSearch(query: String)
}

protocol SearchAppListViewModelOutput {
	var homeModelObservable: Observable<AppInfoList> { get }
}

class SearchAppListViewModel: SearchAppListViewModelInput, SearchAppListViewModelOutput {
	var homeModelObservable: Observable<AppInfoList>
	private let searchAppListUseCase: SearchAppListUseCase
	private var searchAppLoadTask: Cancellable? { willSet { searchAppLoadTask?.cancel() } }

	init(searchAppListUseCase: SearchAppListUseCase) {
		self.searchAppListUseCase = searchAppListUseCase
		self.homeModelObservable = Observable.of()
	}

	func viewDidLoad() {
	}

	func didSearch(query: String) {
		let requestModel = SearchAppListUseCaseRequestModel(query: query)
		searchAppLoadTask = searchAppListUseCase.execute(requestModel: requestModel) { [weak self] (result: Result<AppInfoList, Error>) in
			switch result {
				case .success(let model):
					self?.homeModelObservable = Observable.of(model)
				case .failure(let error):
					print(error)	// TODO: - Error Handling 필요
			}
		}
	}
}
