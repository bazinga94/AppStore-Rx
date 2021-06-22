//
//  AppFlowCoordinator.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import UIKit

class AppFlowCoordinator {
	var navigationController: UINavigationController
	private let appDIContainer: AppDIContainer

	init(navigationController: UINavigationController,
		 appDIContainer: AppDIContainer) {
		self.navigationController = navigationController
		self.appDIContainer = appDIContainer
	}

	func start() {
		// 만약 유저가 회원등록, 로그인 과정이 필요하면 App에서는 여기서 회원등록, 로그인 과정을 수행하면 된다.
		let searchAppSceneDIContainer = appDIContainer.makeSearchAppSceneDIContainer()
		let searchAppSceneFlowCoordinator = searchAppSceneDIContainer.makeSearchAppSceneFlowCoordinator(navigationController: navigationController)
			//moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
		searchAppSceneFlowCoordinator.start()
	}
}
