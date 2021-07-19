//
//  SecondViewController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/07/15.
//

import UIKit

protocol SecondViewActionProtocol: class {
	func dismissAndPopToRoot()
	func finishFlow()
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
		coordinator?.finishFlow()
	}

	static func create(with coordinator: SecondViewActionProtocol) -> SecondViewController {
		let vc = SecondViewController()
		vc.coordinator = coordinator
		return vc
	}
}
