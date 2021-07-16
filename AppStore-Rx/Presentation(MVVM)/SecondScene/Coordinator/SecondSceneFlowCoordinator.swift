//
//  SecondSceneFlowCoordinator.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/07/15.
//

import UIKit

protocol SecondSceneFlowCoordinatorDependency {
	func makeSecondViewController(action: SecondViewActionProtocol) -> SecondViewController
}

class SecondSceneFlowCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	private let dependencies: SecondSceneFlowCoordinatorDependency
	weak var presenter: UIViewController?
	weak var parentCoordinator: SearchAppSceneFlowCoordinator?
	lazy var navigationController: UINavigationController = {
		return UINavigationController()
	}()

	init(dependencies: SecondSceneFlowCoordinatorDependency) {
		self.dependencies = dependencies
	}

//	init(dependencies: SecondSceneFlowCoordinatorDependency, navigationController: UINavigationController) {
//		self.dependencies = dependencies
//		self.navigationController = navigationController
//	}

	func start() {
		let vc = dependencies.makeSecondViewController(action: self)
		navigationController.setViewControllers([vc], animated: false)
		presenter?.present(navigationController, animated: true, completion: nil)
	}
}

extension SecondSceneFlowCoordinator: SecondViewActionProtocol {
	func dismissAndPopToRoot() {
		navigationController.dismiss(animated: true, completion: nil)
		parentCoordinator?.removeChild(self)
	}
}
