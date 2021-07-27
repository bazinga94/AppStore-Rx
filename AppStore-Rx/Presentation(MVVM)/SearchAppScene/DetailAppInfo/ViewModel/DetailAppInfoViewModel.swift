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
	func transform(input: DetailAppInfoViewModel.Input) -> DetailAppInfoViewModel.Output
}

protocol DetailAppInfoViewModelProtocol: DetailAppInfoViewModelInput {
}

class DetailAppInfoViewModel: DetailAppInfoViewModelProtocol {
	private let detailAppInfoAction: DetailAppInfoActionProtocol
	private let appInfo: AppInfo

	init(appInfo: AppInfo, action: DetailAppInfoActionProtocol) {
		self.appInfo = appInfo
		self.detailAppInfoAction = action
	}

	func transform(input: Input) -> Output {
		let iconImage = Driver.of(appInfo)
			.map { $0.appIconImageUrl }
			.asDriver()
		let detail = Driver.of(appInfo)
			.map { $0.description }
			.asDriver()
		let newScene = Driver.of(input.newSceneTrigger)
			.merge()
			.do(onNext: detailAppInfoAction.presentSecondScene)
		let dismiss = Driver.of(input.dismissTrigger)
			.merge()
			.do(onNext: detailAppInfoAction.popDetailAppInfoViewController)

		let output = Output(iconImage: iconImage, detail: detail, newScene: newScene, dismiss: dismiss)
		return output
	}
}

extension DetailAppInfoViewModel {
	struct Input {
		let newSceneTrigger: Driver<Void>
		let dismissTrigger: Driver<Void>
	}

	struct Output {
		let iconImage: Driver<String>
		let detail: Driver<String>
		let newScene: Driver<Void>
		let dismiss: Driver<Void>
	}
}
