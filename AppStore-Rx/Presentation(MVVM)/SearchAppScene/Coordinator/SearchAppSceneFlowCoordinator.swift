//
//  SearchAppSceneFlowCoordinator.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import UIKit

protocol SearchAppSceneFlowCoordinatorDependency {
	func makeSearchAppListViewController(action: SearchAppListActionProtocol) -> SearchAppListViewController
	func makeDetailAppInfoViewController() -> DetailAppInfoViewController
}

class SearchAppSceneFlowCoordinator {
	private let dependencies: SearchAppSceneFlowCoordinatorDependency
	private weak var navigationController: UINavigationController?

	init(dependencies: SearchAppSceneFlowCoordinatorDependency, navigationController: UINavigationController) {
		self.dependencies = dependencies
		self.navigationController = navigationController
	}

	func start() {
		let vc = dependencies.makeSearchAppListViewController(action: self)
		self.navigationController?.pushViewController(vc, animated: false)
	}
}

extension SearchAppSceneFlowCoordinator: SearchAppListActionProtocol {
	func showDetailAppInfoViewController(appInfo: AppInfo) {
		let vc = dependencies.makeDetailAppInfoViewController()	// TODO: view model 주입
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
