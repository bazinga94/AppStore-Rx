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
			.asObservable()
			.compactMap{ $0?.lowercased() }
			.flatMapLatest { [unowned self] query -> Observable<[AppInfo]> in
				return self.viewModel.didSearch(query: query)
//					.catch { error -> Observable<[AppInfo]> in
//						print(error)
//						return Observable.of([])
//					}
			}
//			.catch({ (error) -> Observable<[AppInfo]> in
//				print(error)
//				return Observable.of([])
//			})
			.bind(to: tableView.rx.items(cellIdentifier: SearchAppListTableViewCell.className, cellType: SearchAppListTableViewCell.self)) { row, element, cell in
				cell.iconImageView.load(url: element.appIconImageUrl)
			}	// bind는 onError로 넘어오는 error를 컨트롤 하지 못함
			.disposed(by: bag)

//		appInfoListObservable
//			.subscribe(onError: {
//				print($0)
//			}, onCompleted: {
//				print("completed")
//			}, onDisposed: {
//				print("disposed")
//			})
//			.disposed(by: bag)

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
		return 200
	}
}
