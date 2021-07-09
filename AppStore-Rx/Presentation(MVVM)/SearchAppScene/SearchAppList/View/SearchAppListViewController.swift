//
//  SearchAppListViewController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class SearchAppListViewController: UIViewController, StoryboardInstantiable {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var imageView: UIImageView!

	private var viewModel: SearchAppListViewModelProtocol!
	private var bag = DisposeBag()

	static func create(with viewModel: SearchAppListViewModelProtocol) -> SearchAppListViewController {
		let vc = SearchAppListViewController.instantiateViewController()
		vc.viewModel = viewModel
		return vc
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.viewDidLoad()
		configureSearchBar()
		configureTableView()
		bindViewModel()
	}

	private func bindViewModel() {
		tableView.rx
			.setDelegate(self)
			.disposed(by: bag)

		searchBar.rx
			.text
			.orEmpty		// text를 optional 말고 String으로 받음
//			.asObservable()	// 필요 없을듯
			.throttle(.milliseconds(500), scheduler: MainScheduler.instance)	// 0.5초 동안 새로운 입력 무시
			.distinctUntilChanged()		// 중복 호출 방지
			.compactMap{ $0.lowercased() }
			.flatMapLatest { [unowned self] query -> Observable<[AppInfo]> in
				print(query)
				return self.viewModel.didSearch(query: query)
			}
//			.catchAndReturn([])
//			.catch({ (error) -> Observable<[AppInfo]> in
//				print(error)
//				return Observable.of([])
//			})
			.bind(to: tableView.rx.items(cellIdentifier: SearchAppListTableViewCell.className, cellType: SearchAppListTableViewCell.self)) { row, element, cell in
				cell.iconImageView.kf.indicatorType = .activity		// Indicator 지정 가능
//				cell.iconImageView.load(url: element.appIconImageUrl)
//				cell.iconImageView.kf.setImage(with: URL(string: element.appIconImageUrl))
				cell.iconImageView.kf.setImage(with: URL(string: element.appIconImageUrl), placeholder: UIImage(named: "morty")) { (result) in
					switch result {
						case .success(let value):
							print(value.cacheType)
//							print(value.image)
//							print(value.originalSource)
//							print(value.source)
						case .failure(let error):
							print(error)
					}
				}	// Placeholder 지정 가능
				cell.appName.text = element.appName
				cell.appGenre.text = element.appGenre
				cell.numberOfUsers.text = element.numberOfReviews
//				cell.firstScreenShot.load(url: element.firstScreenShotUrl)
//				cell.secondScreenShot.load(url: element.secondScreenShotUrl)
//				cell.thirdScreenShot.load(url: element.thirdScreenShotUrl)
				cell.firstScreenShot.kf.setImage(with: URL(string: element.firstScreenShotUrl))
				cell.secondScreenShot.kf.setImage(with: URL(string: element.secondScreenShotUrl))
				cell.thirdScreenShot.kf.setImage(with: URL(string: element.thirdScreenShotUrl))
			}	// bind는 onError로 넘어오는 error를 컨트롤 하지 못함
			.disposed(by: bag)

		tableView.rx
			.modelSelected(AppInfo.self)
			.subscribe(onNext: { [weak self] appInfo in
				self?.viewModel.didTapCell(appInfo: appInfo)
			})
			.disposed(by: bag)
	}

	/// searchBar 속성 구성
	private func configureSearchBar() {
		searchBar.delegate = self
		searchBar.placeholder = "게임, 앱, 스토리 등"
		searchBar.searchBarStyle = .minimal
		searchBar.searchTextField.textColor = .lightGray
		searchBar.searchTextField.leftView?.tintColor = .lightGray
	}

	/// tableView 속성 구성
	private func configureTableView() {
		tableView.estimatedRowHeight = 200
	}
}

extension SearchAppListViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
	}
}

extension SearchAppListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 330
	}
}
