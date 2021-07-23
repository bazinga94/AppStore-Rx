//
//  SearchAppListTableViewCell.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/24.
//

import UIKit

class SearchAppListTableViewCell: UITableViewCell {
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var appName: UILabel!
	@IBOutlet weak var appGenre: UILabel!
	@IBOutlet weak var numberOfUsers: UILabel!
	@IBOutlet weak var firstScreenShot: UIImageView!
	@IBOutlet weak var secondScreenShot: UIImageView!
	@IBOutlet weak var thirdScreenShot: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		iconImageView.cornerRadius(by: 10)
		firstScreenShot.cornerRadius(by: 10)
		secondScreenShot.cornerRadius(by: 10)
		thirdScreenShot.cornerRadius(by: 10)
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		iconImageView.image = nil
		firstScreenShot.image = nil
		secondScreenShot.image = nil
		thirdScreenShot.image = nil
	}

	func configure(model: AppInfo) {
		iconImageView.kf.indicatorType = .activity		// Indicator 지정 가능
//		cell.iconImageView.load(url: element.appIconImageUrl)
//		cell.iconImageView.kf.setImage(with: URL(string: element.appIconImageUrl))
		iconImageView.kf.setImage(with: URL(string: model.appIconImageUrl), placeholder: UIImage(named: "morty")) { (result) in
			switch result {
				case .success(let value):
					print(value.cacheType)
//					print(value.image)
//					print(value.originalSource)
//					print(value.source)
				case .failure(let error):
					print(error)
			}
		}	// Placeholder 지정 가능
		appName.text = model.appName
		appGenre.text = model.appGenre
		numberOfUsers.text = model.numberOfReviews
//		cell.firstScreenShot.load(url: element.firstScreenShotUrl)
//		cell.secondScreenShot.load(url: element.secondScreenShotUrl)
//		cell.thirdScreenShot.load(url: element.thirdScreenShotUrl)
		firstScreenShot.kf.setImage(with: URL(string: model.firstScreenShotUrl))
		secondScreenShot.kf.setImage(with: URL(string: model.secondScreenShotUrl))
		thirdScreenShot.kf.setImage(with: URL(string: model.thirdScreenShotUrl))
	}
}
