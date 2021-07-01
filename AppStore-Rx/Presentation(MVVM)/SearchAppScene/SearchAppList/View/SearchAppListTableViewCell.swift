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
}
