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
	var homeModelObservable: Observable<[AppInfoList]> { get }
}

class SearchAppListViewModel: SearchAppListViewModelInput, SearchAppListViewModelOutput {
	var homeModelObservable: Observable<[AppInfoList]>

	init() {
		self.homeModelObservable = Observable.of([])
	}

	func viewDidLoad() {
	}

	func didSearch(query: String) {

	}
}
