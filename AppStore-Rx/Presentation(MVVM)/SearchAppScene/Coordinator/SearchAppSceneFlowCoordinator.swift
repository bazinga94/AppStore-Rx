//
//  SearchAppSceneFlowCoordinator.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import UIKit

protocol SearchAppSceneFlowCoordinatorDependency {
	func makeSearchAppListViewController(action: SearchAppListActionProtocol) -> SearchAppListViewController
	func makeDetailAppInfoViewController(appInfo: AppInfo, action: DetailAppInfoActionProtocol) -> DetailAppInfoViewController
}

class SearchAppSceneFlowCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	private let dependencies: SearchAppSceneFlowCoordinatorDependency
	var navigationController: UINavigationController

	init(dependencies: SearchAppSceneFlowCoordinatorDependency, navigationController: UINavigationController) {
		self.dependencies = dependencies
		self.navigationController = navigationController
	}

	func start() {
		let vc = dependencies.makeSearchAppListViewController(action: self)
		self.navigationController.pushViewController(vc, animated: false)
	}
}

extension SearchAppSceneFlowCoordinator: SearchAppListActionProtocol {
	func showDetailAppInfoViewController(appInfo: AppInfo) {
		let vc = dependencies.makeDetailAppInfoViewController(appInfo: appInfo, action: self)	// TODO: view model 주입
		self.navigationController.pushViewController(vc, animated: true)
	}
}

extension SearchAppSceneFlowCoordinator: DetailAppInfoActionProtocol {
	func popDetailAppInfoViewController() {
		self.navigationController.popViewController(animated: true)
	}

	func presentSecondScene() {
		let secondSceneDIContainer = SecondSceneDIContainer()
		let secondSceneFlowCoordinator = secondSceneDIContainer.makeSecondSceneFlowCoordinator()
		secondSceneFlowCoordinator.presenter = navigationController
		childCoordinators.append(secondSceneFlowCoordinator)
		secondSceneFlowCoordinator.parentCoordinator = self
		secondSceneFlowCoordinator.start()
	}
}
