//
//  SearchAppListViewModel.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchAppListActionProtocol {
	func showDetailAppInfoViewController(appInfo: AppInfo)
}

protocol SearchAppListViewModelInput {
	func viewDidLoad()
	func didSearch(query: String) -> Observable<[AppInfo]>
	func didTapCell(appInfo: AppInfo)
}

protocol SearchAppListViewModelOutput {
	var appInfoListObservable: Observable<[AppInfo]> { get }
}

protocol SearchAppListViewModelProtocol: SearchAppListViewModelInput, SearchAppListViewModelOutput {
}

class SearchAppListViewModel: SearchAppListViewModelProtocol {
	var appInfoListObservable: Observable<[AppInfo]>
	private let searchAppListUseCase: SearchAppListUseCaseProtocol
	private let searchAppListAction: SearchAppListActionProtocol
	private var searchAppLoadTask: Cancellable? {
		willSet {
			searchAppLoadTask?.cancel()
		}
	}

	init(useCase: SearchAppListUseCaseProtocol, action: SearchAppListActionProtocol) {
		self.searchAppListUseCase = useCase
		self.searchAppListAction = action
		self.appInfoListObservable = Observable.of([])
	}

	func viewDidLoad() {
	}

	func didSearch(query: String) -> Observable<[AppInfo]> {
		self.appInfoListObservable = Observable.create { emitter in

			// defer 사용?

			let requestModel = SearchAppListUseCaseRequestModel(query: query)
			self.searchAppLoadTask = self.searchAppListUseCase.execute(requestModel: requestModel) { (result: Result<AppInfoList, Error>) in
				switch result {
					case .success(let model):
						emitter.onNext(model.displayedApps)
					case .failure(let error):
						print(error)
						emitter.onNext([])
//						emitter.onError(error)	// 에러로 처리하지 않고 빈 array return
				}
			}

			return Disposables.create {
				self.searchAppLoadTask?.cancel()
			}
		}
		return self.appInfoListObservable
	}

	func didTapCell(appInfo: AppInfo) {
		self.searchAppListAction.showDetailAppInfoViewController(appInfo: appInfo)
	}
}
