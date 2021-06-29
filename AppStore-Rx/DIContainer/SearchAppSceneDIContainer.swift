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

	private lazy var searchAppListViewModel: SearchAppListViewModel = {
		return SearchAppListViewModel(searchAppListUseCase: searchAppListUseCase)
	}()

	private lazy var searchAppListUseCase: SearchAppListUseCase = {
		return SearchAppListUseCase(appInfoListRepository: appInfoListRepository)
	}()

	private lazy var appInfoListRepository: AppInfoListRepository = {
		return AppInfoListRepository(dataTransferService: dependencies.apiDataTransferService)
	}()
}

extension SearchAppSceneDIContainer: SearchAppSceneFlowCoordinatorDependency {
	func makeSearchAppListViewController() -> SearchAppListViewController {
		return SearchAppListViewController.create(with: searchAppListViewModel)
	}

//	private func makeSearchAppListViewModel() -> SearchAppListViewModel {
//		return SearchAppListViewModel(searchAppListUseCase: makeSearchAppListUseCase())
//	}
//
//	private func makeSearchAppListUseCase() -> SearchAppListUseCase {
//		return SearchAppListUseCase(appInfoListRepository: makeAppInfoListRepository())
//	}
//
//	private func makeAppInfoListRepository() -> AppInfoListRepository {
//		return AppInfoListRepository(dataTransferService: dependencies.apiDataTransferService)
//	}
}

