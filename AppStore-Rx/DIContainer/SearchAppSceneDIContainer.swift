//
//  SearchAppSceneDIContainer.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import UIKit

class SearchAppSceneDIContainer {
	struct Dependency {
		let apiDataTransferService: DataTransferService
	}

	private let dependencies: Dependency

	init(dependencies: Dependency) {
		self.dependencies = dependencies
	}

	func makeSearchAppSceneFlowCoordinator(navigationController: UINavigationController) -> SearchAppSceneFlowCoordinator {
		return SearchAppSceneFlowCoordinator(dependencies: self, navigationController: navigationController)
	}
}

extension SearchAppSceneDIContainer: SearchAppSceneFlowCoordinatorDependency {
	func makeSearchAppListViewController() -> SearchAppListViewController {
		return SearchAppListViewController.create(with: makeSearchAppListViewModel())
	}

	func makeSearchAppListViewModel() -> SearchAppListViewModel {
		return SearchAppListViewModel(searchAppListUseCase: makeSearchAppListUseCase())
	}

	func makeSearchAppListUseCase() -> SearchAppListUseCase {
		return SearchAppListUseCase(appInfoListRepository: makeAppInfoListRepository())
	}

	func makeAppInfoListRepository() -> AppInfoListRepository {
		return AppInfoListRepository(dataTransferService: dependencies.apiDataTransferService)
	}
}

