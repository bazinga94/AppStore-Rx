//
//  ApiConfig.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/24.
//

import Foundation

enum NetworkConfig {
	static let baseURL = "https://itunes.apple.com/"
}

struct AppStoreApi {
	var word: String
	var limit: Int
	var url: String {
		get {
			return NetworkConfig.baseURL + "search?term=\(word)&country=kr&media=software&entity=software&limit=\(String(limit))"
		}
	}
}
