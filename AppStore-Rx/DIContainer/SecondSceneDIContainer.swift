//
//  SecondSceneDIContainer.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/07/15.
//

import UIKit

class SecondSceneDIContainer {
	func makeSecondSceneFlowCoordinator() -> SecondSceneFlowCoordinator {
		return SecondSceneFlowCoordinator(dependencies: self)
	}
}

extension SecondSceneDIContainer: SecondSceneFlowCoordinatorDependency {
	func makeSecondViewController(action: SecondViewActionProtocol) -> SecondViewController {
		let vc = SecondViewController.create(with: action)
		return vc
	}
}
