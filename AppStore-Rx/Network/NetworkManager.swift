//
//  NetworkManager.swift
//  AppStore-Rx
//
//  Created by Jongho Lee on 2021/06/23.
//

import Foundation

protocol Cancellable {
	func cancel()
}

protocol NetworkCancellable {
	func cancel()
}

extension URLSessionTask: NetworkCancellable { }

enum APIError: Error {
	case unknown
	case httpStatus
	case decodingJSON
	case dataNil
	//	var errorDescription: String? { "description of error" }
}

enum HttpMethod: String {
	case GET
	case POST
}

protocol NetworkManagerProtocol {
	func request<T: Decodable>(url: URL, type: HttpMethod, completion: @escaping (Result<T, APIError>) -> Void) -> NetworkCancellable?
}
