//
//  SecondViewController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/07/15.
//

import UIKit

protocol SecondViewActionProtocol: class {
	func dismissAndPopToRoot()
}

class SecondViewController: UIViewController {

	@IBAction func dismissAction(_ sender: Any) {
		coordinator?.dismissAndPopToRoot()
	}

	weak var coordinator: SecondViewActionProtocol?

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		if let coordinator = coordinator as? Coordinator {
			coordinator.removeChild(coordinator)
		}
	}

	static func create(with coordinator: SecondViewActionProtocol) -> SecondViewController {
		let vc = SecondViewController()
		vc.coordinator = coordinator
		return vc
	}
}
