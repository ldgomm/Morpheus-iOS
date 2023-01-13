//
//  AuthenticationServiceable.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Combine
import Foundation

protocol AuthenticationServiceable {
    
    func validateToken(_ authenticationApiRequest: AuthenticationApiRequest, completion: @escaping (Result<AuthenticationApiResponse, UploadError>) -> Void) -> Void
    
}

enum UploadError: Error {
    case decodeError, uploadError
}

//protocol Serviceable {
//    func getData<T>(endpoint: String, completion: @escaping (Result<T, DownloadError>) -> Void) -> Void where T: Decodable
//}
//
//final class Service: Serviceable {
//    private var cancellables: Set<AnyCancellable>
//
//    init() {
//        cancellables = []
//    }
//
//    func getData<T>(endpoint: String, completion: @escaping (Result<T, DownloadError>) -> Void) -> Void where T: Decodable {
//        var request: URLRequest = .init(url: URL(string: "\(base_url)/\(endpoint)")!)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = UserDefaults.standard.value(forKey: "allHeaderFields") as? [String : String]
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .retry(1)
//            .tryMap { data, response in
//                guard let httpResponse  = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
//            .decode(type: T.self, decoder: JSONDecoder())
//            .map(Result.success)
//            .catch { error -> Just<Result<T, DownloadError>> in
//                error is Decodable ? Just(.failure(.decodeError)) : Just(.failure(.decodeError))
//            }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: completion)
//            .store(in: &cancellables)
//    }
//}
