//
//  DetailAppInfoViewModel.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/07/01.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailAppInfoActionProtocol {
	func popDetailAppInfoViewController()
	func presentSecondScene()
}

protocol DetailAppInfoViewModelInput {
//	func viewDidLoad() -> Observable<AppInfo>
//	func popViewController()
//	func presentNewScene()
	func transform(input: DetailAppInfoViewModel.Input) -> DetailAppInfoViewModel.Output
}

protocol DetailAppInfoViewModelProtocol: DetailAppInfoViewModelInput {
}

class DetailAppInfoViewModel: DetailAppInfoViewModelProtocol {
	private let detailAppInfoAction: DetailAppInfoActionProtocol
	private let appInfoObservable: Observable<AppInfo>

	init(appInfo: AppInfo, action: DetailAppInfoActionProtocol) {
		appInfoObservable = Observable.create { emitter in
			emitter.onNext(appInfo)
			return Disposables.create()
		}
		self.detailAppInfoAction = action
	}

	func transform(input: Input) -> Output {
		let newScene = Driver.of(input.newSceneTrigger)
			.merge()
			.do(onNext: detailAppInfoAction.presentSecondScene)
		let dismiss = Driver.of(input.dismissTrigger)
			.merge()
			.do(onNext: detailAppInfoAction.popDetailAppInfoViewController)

		let output = Output(newScene: newScene, dismiss: dismiss)
		return output
	}

//	func viewDidLoad() -> Observable<AppInfo> {
//		return appInfoObservable
//	}
//
//	func popViewController() {
//		detailAppInfoAction.popDetailAppInfoViewController()
//	}
//
//	func presentNewScene() {
//		detailAppInfoAction.presentSecondScene()
//	}
}

extension DetailAppInfoViewModel {
	struct Input {
		let newSceneTrigger: Driver<Void>
		let dismissTrigger: Driver<Void>
	}

	struct Output {
		let newScene: Driver<Void>
		let dismiss: Driver<Void>
	}
}
