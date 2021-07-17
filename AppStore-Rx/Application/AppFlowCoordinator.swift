//
//  AppFlowCoordinator.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import UIKit

protocol Coordinator: class {
	var childCoordinators: [Coordinator] { get set }
	var navigationController: UINavigationController { get set }
	func start()
	func removeChild(_ coordinator: Coordinator)
}

extension Coordinator {
	func removeChild(_ coordinator: Coordinator) {
		childCoordinators = childCoordinators.filter { $0 !== coordinator }
	}
}

class AppFlowCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	var navigationController: UINavigationController
	private let appDIContainer: AppDIContainer

	init(navigationController: UINavigationController,
		 appDIContainer: AppDIContainer) {
		self.navigationController = navigationController
		self.appDIContainer = appDIContainer
	}

	func start() {
		// TODO: - 만약 유저가 회원등록, 로그인 과정이 필요하면 App에서는 여기서 hooking하여 회원등록, 로그인 과정을 수행하면 된다.
		let searchAppSceneDIContainer = appDIContainer.makeSearchAppSceneDIContainer()
		let searchAppSceneFlowCoordinator = searchAppSceneDIContainer.makeSearchAppSceneFlowCoordinator(navigationController: navigationController)
		searchAppSceneFlowCoordinator.start()
	}
}
