//
//  SearchAppSceneDIContainer.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

class SearchAppSceneDIContainer {
	struct Dependency {
		let apiDataTransferService: DataTransferService
	}

	private let dependencies: Dependency

	init(dependencies: Dependency) {
		self.dependencies = dependencies
	}
}
