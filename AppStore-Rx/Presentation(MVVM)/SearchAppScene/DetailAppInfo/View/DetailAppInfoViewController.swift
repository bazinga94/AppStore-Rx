//
//  DetailAppInfoViewController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/30.
//

import UIKit
import RxSwift
import Kingfisher

class DetailAppInfoViewController: UIViewController {

	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!

	@IBAction func backButton(_ sender: Any) {
//		viewModel.popViewController()
	}

	@IBAction func newScene(_ sender: Any) {
//		viewModel.presentNewScene()
	}

	@IBOutlet weak var newSceneButton: UIButton!
	@IBOutlet weak var backButton: UIButton!

	private var viewModel: DetailAppInfoViewModelProtocol!
	private var disposedBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
//		viewModel.viewDidLoad()
//			.observe(on: MainScheduler.instance)
//			.subscribe(onNext: { [weak self] appInfo in
////				self?.iconImageView.load(url: appInfo.appIconImageUrl)
//				self?.iconImageView.kf.setImage(with: URL(string: appInfo.appIconImageUrl))
//				self?.descriptionLabel.text = appInfo.description
//			})
//			.disposed(by: bag)
		bind()
	}

	private func bind() {
		let input = DetailAppInfoViewModel.Input(
			newSceneTrigger: newSceneButton.rx.tap.asDriver(),
			dismissTrigger: backButton.rx.tap.asDriver()
		)
		let output = viewModel.transform(input: input)

		output.newScene.drive()
			.disposed(by: disposedBag)
		output.dismiss.drive()
			.disposed(by: disposedBag)
	}

	static func create(with viewModel: DetailAppInfoViewModelProtocol) -> DetailAppInfoViewController {
		let vc = DetailAppInfoViewController()
		vc.viewModel = viewModel
		return vc
	}
}
