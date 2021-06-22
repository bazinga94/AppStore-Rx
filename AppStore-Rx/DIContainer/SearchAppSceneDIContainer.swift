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
		return SearchAppListViewController()	// TODO: ViewModel 과 Repository를 inject 해줘야함
	}
}
