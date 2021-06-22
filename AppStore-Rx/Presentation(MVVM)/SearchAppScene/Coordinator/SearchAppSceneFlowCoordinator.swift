//
//  SearchAppSceneFlowCoordinator.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import UIKit

protocol SearchAppSceneFlowCoordinatorDependency {
	func makeSearchAppListViewController() -> SearchAppListViewController
}

class SearchAppSceneFlowCoordinator {
	private let dependencies: SearchAppSceneFlowCoordinatorDependency
	private weak var navigationController: UINavigationController?

	init(dependencies: SearchAppSceneFlowCoordinatorDependency, navigationController: UINavigationController) {
		self.dependencies = dependencies
		self.navigationController = navigationController
	}

	func start() {
		let vc = dependencies.makeSearchAppListViewController()
		self.navigationController?.pushViewController(vc, animated: false)
	}
}
