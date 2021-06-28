//
//  SearchAppListViewController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchAppListViewController: UIViewController, StoryboardInstantiable {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var imageView: UIImageView!

	private var viewModel: SearchAppListViewModel!
	private var bag = DisposeBag()

	static func create(with viewModel: SearchAppListViewModel) -> SearchAppListViewController {
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
			.asObservable()
			.compactMap{ $0?.lowercased() }
			.flatMapLatest { [unowned self] query -> Observable<[AppInfo]> in
				return self.viewModel.didSearch(query: query)
			}
			.bind(to: tableView.rx.items(cellIdentifier: SearchAppListTableViewCell.className, cellType: SearchAppListTableViewCell.self)) { row, element, cell in
				cell.iconImageView.load(url: element.appIconImageUrl)
			}
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
//		guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
//		if searchText.count == 0 { return }
//		viewModel.didSearch(query: searchText)
//			.observe(on: MainScheduler.instance)
//			.subscribe(onNext: { [weak self] appInfoList in //, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//				if appInfoList.count == 0 { return }
//				self?.imageView.load(url: appInfoList[0].appIconImageUrl)
//				self?.tableView.reloadData()
//			})
//			.disposed(by: bag)
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//		guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
//		if searchText.count == 0 { return }
//		viewModel.didSearch(query: searchText)
//			.observe(on: MainScheduler.instance)
//			.subscribe(onNext: { [weak self] appInfoList in //, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//				if appInfoList.count == 0 { return }
//				self?.imageView.load(url: appInfoList[0].appIconImageUrl)
//				self?.tableView.reloadData()
//			})
//			.disposed(by: bag)
	}
}

extension SearchAppListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}
}
