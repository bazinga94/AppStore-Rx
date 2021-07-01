//
//  DetailAppInfoViewController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/30.
//

import UIKit
import RxSwift

class DetailAppInfoViewController: UIViewController {

	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!

	private var viewModel: DetailAppInfoViewModelProtocol!
	private var bag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.viewDidLoad()
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { [weak self] appInfo in
				self?.iconImageView.load(url: appInfo.appIconImageUrl)
				self?.descriptionLabel.text = appInfo.description
			})
			.disposed(by: bag)
	}

	static func create(with viewModel: DetailAppInfoViewModelProtocol) -> DetailAppInfoViewController {
		let vc = DetailAppInfoViewController()
		vc.viewModel = viewModel
		return vc
	}
}
