//
//  AppCoordinator.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

class AppDIContainer {

	lazy var apiDataTransferService: DataTransferService = {
		return SearchAppDataTransferService()
	}()

	// MARK: - DIContainers of scenes
	func makeSearchAppSceneDIContainer() -> SearchAppSceneDIContainer {
		let dependencies = SearchAppSceneDIContainer.Dependency(apiDataTransferService: apiDataTransferService)
		return SearchAppSceneDIContainer(dependencies: dependencies)
	}
}
