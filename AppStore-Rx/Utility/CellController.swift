//
//  CellController.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/08/30.
//

import UIKit

protocol ReusableCell: class {
	associatedtype CellHolder: ReusableCellHolder
}

extension UITableViewCell: ReusableCell {
	typealias CellHolder = UITableView
}

extension UICollectionViewCell: ReusableCell {
	typealias CellHolder = UICollectionView
}

protocol ReusableCellHolder: class {
	associatedtype CellType: ReusableCell where CellType.CellHolder == Self

	func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String)
	func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> CellType
}

extension UITableView: ReusableCellHolder {

	func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
		register(nib, forCellReuseIdentifier: identifier)
	}

	func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
		return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
	}
}

extension UICollectionView: ReusableCellHolder {

}

protocol CellControllerType {
	associatedtype ViewType: ReusableCellHolder

	static func registerCell(on reusableCellHolder: ViewType)
	func cellFromReusableCellHolder(_ reusableCellHolder: ViewType, forIndexPath indexPath: IndexPath) -> ViewType.CellType
	func didSelectCell(itemAt indexPath: IndexPath)
}

class CellController<T: ReusableCellHolder>: CellControllerType {

	class var cellClass: AnyClass {		// override 가능
		fatalError("Must be implemented by children")
	}

	static var cellIdentifier: String {
		return String(describing: cellClass)
	}

	static func registerCell(on reusableCellHolder: T) {
		let bundle = Bundle(for: cellClass)
		let nib = UINib(nibName: cellIdentifier, bundle: bundle)
		reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
	}

	func cellFromReusableCellHolder(_ reusableCellHolder: T, forIndexPath indexPath: IndexPath) -> T.CellType {
		let cell = reusableCellHolder.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath)
		configureCell(cell)
		return cell
	}

	func configureCell(_ cell: T.CellType) {
		// 자식 클래스에서 override하여 구현
	}

	func didSelectCell(itemAt indexPath: IndexPath) {
		// 자식 클래스에서 override하여 구현
	}
}

class GenericCellController<T: ReusableCell>: CellController<T.CellHolder> {

	typealias BaseReusableCell = T.CellHolder.CellType

	final override class var cellClass: AnyClass {
		return T.self
	}

	final override func configureCell(_ cell: BaseReusableCell) {
		let cell = cell as! T
		configureCell(cell)
	}

	func configureCell(_ cell: T) {
		// Generic 타입을 인자로 받아 override 하여 구현
	}
}
