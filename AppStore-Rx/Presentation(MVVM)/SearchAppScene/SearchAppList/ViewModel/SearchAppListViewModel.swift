//
//  SearchAppListViewModel.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

protocol SearchAppListViewModelInput {
	func viewDidLoad()
	func didSearch(query: String)
}

protocol SearchAppListViewModelOutput {

}

protocol SearchAppListViewModel {

}
