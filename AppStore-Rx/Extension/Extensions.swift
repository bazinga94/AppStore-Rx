//
//  Extensions.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/21.
//

import UIKit

extension UIView {
	class func instanceFromNib<T: UIView>() -> T {
		return UINib(nibName: "nib file name", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! T
	}
}

extension NSObject {
	/// 클래스명
	class var className: String {
		return String(describing: self)
	}
}

extension UITableViewCell {
	/// 클래스명(Identifier를 클래스명과 동일하게 설정)
	static var reusableIdentifier: String {
		return String(describing: self)
	}
}

extension UICollectionViewCell {
	/// 클래스명(Identifier를 클래스명과 동일하게 설정)
	static var reusableIdentifier: String {
		return String(describing: self)
	}
}

extension UITableView {
	func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
		guard let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
			fatalError("Disable Dequeue Reusable Cell")
		}
		return cell
	}
}

extension UICollectionView {
	func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
		guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
			fatalError("Disable Dequeue Reusable Cell")
		}
		return cell
	}
}

extension Array {
	subscript (safe index: Int) -> Element? {
		return indices ~= index ? self[index] : nil
	}
}

struct ImageCache {
	static var shared = NSCache<AnyObject, AnyObject>()
}

extension UIImageView {
	/// UIImageView에 해당 URL 이미지를 load(이미지 캐시 사용)
	/// - Parameter url: URL
	func load(url: String) {
		self.image = nil
		if let image = ImageCache.shared.object(forKey: url as NSString) as? UIImage {
			self.image = image
			return
		}

		DispatchQueue.global().async { [weak self] in
			if let loadUrl = URL(string: url), let data = try? Data(contentsOf: loadUrl) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						ImageCache.shared.setObject(image , forKey: url as NSString)
						self?.image = image
					}
				}
			}
		}
	}

	/// UIImageView 모서리를 둥글게 변경
	/// - Parameter radius: radius
	func cornerRadius(by radius: CGFloat) {
		self.layer.borderWidth = 1
		self.layer.masksToBounds = false
		self.layer.borderColor = UIColor.black.cgColor
		self.layer.cornerRadius = radius
		self.clipsToBounds = true
	}
}
