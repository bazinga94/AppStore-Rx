//
//  SearchAppListRepository.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

protocol AppInfoListRepositoryProtocol {
	func fetchAppInfoList(query: AppInfoListQuery,
						  completion: @escaping (Result<AppInfoList, Error>) -> Void) -> Cancellable?
}

class AppInfoListRepository: AppInfoListRepositoryProtocol {

	private let dataTransferService: NetworkManagerProtocol

	init(dataTransferService: NetworkManagerProtocol) {
		self.dataTransferService = dataTransferService
	}

	func fetchAppInfoList(query: AppInfoListQuery, completion: @escaping (Result<AppInfoList, Error>) -> Void) -> Cancellable? {

		let api = AppStoreApi(word: query.query, limit: 50)
		guard let searchUrl = encodeCharacterUrl(urlString: api.url) else { return nil }	// nil을 return 하면 안될것 같음

		let task = RepositoryTask()
		task.networkTask = dataTransferService.request(url: searchUrl, type: .GET, completion: { (result: Result<AppInfoListDTO, APIError>) in
			switch result {
				case .success(let model):
					completion(.success(model.toDomain()))
				case .failure(let error):	// TODO: - Error Handling 필요?
					completion(.failure(error))
			}
		})
		
		return task
	}

	/// character set url 인코딩
	/// - Parameter urlString: URL
	private func encodeCharacterUrl(urlString: String) -> URL? {
		guard
			let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),	// 한글 인코딩 처리
			let url = URL(string: encodedString) else {
			return nil
		}
		return url
	}
}
