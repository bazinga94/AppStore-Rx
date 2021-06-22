//
//  SearchAppResponse+Mapping.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

/// 통신 API response body의 최상위 모델
struct AppInfoListDTO: Codable {
	/// 검색결과 앱 개수
	let resultCount: Int
	/// 검색결과 앱의 정보 리스트
	let results: [AppInfoDTO]

	/// 통신 API의 results 리스트 성분 모델
	struct AppInfoDTO: Codable {
		/// app 스크린샷 이미지 url들
		let screenshotUrls: [String]
		/// app icon 이미지 url
		let artworkUrl512: String
		/// app ID
		let trackId: Int
		/// app 이름
		let trackName: String
		/// 장르(서브 타이틀)
		let genres: [String]
		/// 평점수
		let userRatingCount: Int
		/// 연령
		let contentAdvisoryRating: String
		/// 평균 평점
		let averageUserRating: Double
		/// 릴리즈 노트
		let releaseNotes: String
		/// 앱 설명
		let description: String
		/// 개발자
		let artistName: String
		/// 앱 버젼
		let version: String
		/// 최근 release 날짜
		let currentVersionReleaseDate: String
	}
}

extension AppInfoListDTO {
	func toDomain() -> AppInfoList {
		return AppInfoList(displayedApps: results.map { $0.toDomain() },
						   totalCount: resultCount)
	}
}

extension AppInfoListDTO.AppInfoDTO {
	func toDomain() -> AppInfo {
		return AppInfo(appIconImageUrl: artworkUrl512,
					   appName: trackName,
					   appGenre: genres[0],
					   numberOfReviews: String(userRatingCount),
					   firstScreenShotUrl: screenshotUrls[0],
					   secondScreenShotUrl: screenshotUrls[1],
					   thirdScreenShotUrl: screenshotUrls[2],
					   averageUserRating: averageUserRating)
	}
}
