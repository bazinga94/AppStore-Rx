//
//  SearchAppListViewModel.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchAppListViewModelInput {
	func viewDidLoad()
	func didSearch(query: String) -> Observable<[AppInfo]>
}

protocol SearchAppListViewModelOutput {
	var appInfoListObservable: Observable<[AppInfo]> { get }
}

protocol SearchAppListViewModelProtocol: SearchAppListViewModelInput, SearchAppListViewModelOutput {
}

class SearchAppListViewModel: SearchAppListViewModelProtocol {
	var appInfoListObservable: Observable<[AppInfo]>
	private let searchAppListUseCase: SearchAppListUseCaseProtocol
	private var searchAppLoadTask: Cancellable? {
		willSet {
			searchAppLoadTask?.cancel()
		}
	}

	init(searchAppListUseCase: SearchAppListUseCaseProtocol) {
		self.searchAppListUseCase = searchAppListUseCase
		self.appInfoListObservable = Observable.of([])
	}

	func viewDidLoad() {
	}

	func didSearch(query: String) -> Observable<[AppInfo]> {
		self.appInfoListObservable = Observable.create { emitter in

			let requestModel = SearchAppListUseCaseRequestModel(query: query)
			self.searchAppLoadTask = self.searchAppListUseCase.execute(requestModel: requestModel) { [weak self] (result: Result<AppInfoList, Error>) in
				switch result {
					case .success(let model):
						emitter.onNext(model.displayedApps)
						emitter.onCompleted()
//						print(model)
					case .failure(let error):
						emitter.onError(error)
//						print(error)	// TODO: - Error Handling 필요
				}
			}

			return Disposables.create {
				self.searchAppLoadTask?.cancel()
			}
		}
		return self.appInfoListObservable
	}
}
