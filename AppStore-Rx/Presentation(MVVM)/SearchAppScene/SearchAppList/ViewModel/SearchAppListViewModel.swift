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

class SearchAppListViewModel: SearchAppListViewModelInput, SearchAppListViewModelOutput {
	var appInfoListObservable: Observable<[AppInfo]>
	private let searchAppListUseCase: SearchAppListUseCase
	private var searchAppLoadTask: Cancellable? { willSet { searchAppLoadTask?.cancel() } }

	init(searchAppListUseCase: SearchAppListUseCase) {
		self.searchAppListUseCase = searchAppListUseCase
		self.appInfoListObservable = Observable.of([AppInfo(appIconImageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/e8/d9/e9/e8d9e924-852b-cb7b-3852-432ef6941ae3/source/512x512bb.jpg", appName: "WorldBox - 샌드 박스 새로운 시뮬레이터", appGenre: "게임", numberOfReviews: "375", firstScreenShotUrl: "https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/c3/08/8f/c3088fad-ade5-e39f-93c6-129d7f2817b1/pr_source.png/392x696bb.png", secondScreenShotUrl: "https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/c3/08/8f/c3088fad-ade5-e39f-93c6-129d7f2817b1/pr_source.png/392x696bb.png", thirdScreenShotUrl: "https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/c3/08/8f/c3088fad-ade5-e39f-93c6-129d7f2817b1/pr_source.png/392x696bb.png", averageUserRating: 4.655989999999998)])
	}

	func viewDidLoad() {
	}

	func didSearch(query: String) -> Observable<[AppInfo]> {
		return Observable.create { emitter in

			let requestModel = SearchAppListUseCaseRequestModel(query: query)
			self.searchAppLoadTask = self.searchAppListUseCase.execute(requestModel: requestModel) { [weak self] (result: Result<AppInfoList, Error>) in
				switch result {
					case .success(let model):
//						self?.appInfoListObservable = Observable.of(model.displayedApps)
						emitter.onNext(model.displayedApps)
//						emitter.onCompleted()
					case .failure(let error):
						print(error)	// TODO: - Error Handling 필요
				}
			}

			return Disposables.create {
				self.searchAppLoadTask?.cancel()
			}
		}
//		let requestModel = SearchAppListUseCaseRequestModel(query: query)
//		searchAppLoadTask = searchAppListUseCase.execute(requestModel: requestModel) { [weak self] (result: Result<AppInfoList, Error>) in
//			switch result {
//				case .success(let model):
//					self?.appInfoListObservable = Observable.of(model.displayedApps)
//				case .failure(let error):
//					print(error)	// TODO: - Error Handling 필요
//			}
//		}
	}
}
