//
//  SecondViewController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/07/15.
//

import UIKit

protocol SecondViewActionProtocol {
	func dismissAndPopToRoot()
}

class SecondViewController: UIViewController {

	@IBAction func dismissAction(_ sender: Any) {
		coordinator.dismissAndPopToRoot()
	}

	private var coordinator: SecondViewActionProtocol!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	static func create(with coordinator: SecondViewActionProtocol) -> SecondViewController {
		let vc = SecondViewController()
		vc.coordinator = coordinator
		return vc
	}
}
