//
//  SearchAppListViewController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/21.
//

import UIKit

class SearchAppListViewController: UIViewController, StoryboardInstantiable {

	@IBOutlet weak var searchBar: UISearchBar!

	override func viewDidLoad() {
		super.viewDidLoad()
		configureSearchBar()
	}

	/// searchBar 속성 구성
	private func configureSearchBar() {
		searchBar.delegate = self
		searchBar.placeholder = "게임, 앱, 스토리 등"
		searchBar.searchBarStyle = .minimal
		searchBar.searchTextField.textColor = .lightGray
		searchBar.searchTextField.leftView?.tintColor = .lightGray
	}
}

extension SearchAppListViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
		if searchText.count == 0 { return }
		// TODO: ViewModel 로직
	}
}
