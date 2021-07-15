//
//  DetailAppInfoViewModel.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/07/01.
//

import Foundation
import RxSwift

protocol DetailAppInfoActionProtocol {
	func popDetailAppInfoViewController()
}

protocol DetailAppInfoViewModelInput {
	func viewDidLoad() -> Observable<AppInfo>
	func popViewController()
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

	func viewDidLoad() -> Observable<AppInfo> {
		return appInfoObservable
	}

	func popViewController() {
		detailAppInfoAction.popDetailAppInfoViewController()
	}
}
