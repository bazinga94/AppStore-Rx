//
//  DetailAppInfoViewModel.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/07/01.
//

import Foundation
import RxSwift

protocol DetailAppInfoViewModelInput {
	func viewDidLoad() -> Observable<AppInfo>
}

protocol DetailAppInfoViewModelProtocol: DetailAppInfoViewModelInput {
}

class DetailAppInfoViewModel: DetailAppInfoViewModelProtocol {

	private let appInfoObservable: Observable<AppInfo>

	init(appInfo: AppInfo) {
		appInfoObservable = Observable.create { emitter in
			emitter.onNext(appInfo)
			return Disposables.create()
		}
	}

	func viewDidLoad() -> Observable<AppInfo> {
		return appInfoObservable
	}
}
