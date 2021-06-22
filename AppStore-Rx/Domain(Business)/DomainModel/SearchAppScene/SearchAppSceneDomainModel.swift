//
//  SearchAppSceneDomainModel.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

struct AppInfoList {
	let displayedApps: [AppInfo]
	let totalCount: Int
}

struct AppInfo {
	let appIconImageUrl: String
	let appName: String
	let appGenre: String
	let numberOfReviews: String
	let firstScreenShotUrl: String
	let secondScreenShotUrl: String
	let thirdScreenShotUrl: String
	let averageUserRating: Double
}
