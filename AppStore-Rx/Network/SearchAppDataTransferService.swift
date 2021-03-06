//
//  SearchAppDataTransferService.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/22.
//

import Foundation

class SearchAppDataTransferService: NetworkManagerProtocol {

	var session: URLSession

	required init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	func request<T>(url: URL, type: HttpMethod, completion: @escaping (Result<T, APIError>) -> Void) -> NetworkCancellable? where T : Decodable {
		var request = URLRequest(url: url)
		request.httpMethod = type.rawValue

		let task: URLSessionDataTask = session
			.dataTask(with: request) { data, urlResponse, error in
				guard let response = urlResponse as? HTTPURLResponse,
					  (200...399).contains(response.statusCode) else {
					return completion(.failure(.httpStatus))
				}

				guard let data = data else {
					return completion(.failure(.dataNil))
				}
				do {
					let model = try JSONDecoder().decode(T.self, from: data)
//					print(String(data: data, encoding: .utf8))
					return completion(.success(model))
				} catch {
					print(error)
					return completion(.failure(.decodingJSON))
				}
			}
		task.resume()
		return task
	}
}
