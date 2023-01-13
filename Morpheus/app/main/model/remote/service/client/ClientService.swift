//
//  ClientService.swift
//  Morpheus
//
//  Created by José Ruiz on 12/1/23.
//

import Combine
import Foundation

class ClientService: ClientServiceable {
    private var cancellables: Set<AnyCancellable>
    
    init() {
        cancellables = []
    }
    
//    func getClient(completion: @escaping (Result<ClientApiResponse, DownloadError>) -> Void) -> Void {
//        var request: URLRequest = .init(url: URL(string: "\(base_url)/client")!)
////        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = UserDefaults.standard.value(forKey: "allHeaderFields") as? [String : String]
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map(\.data)
//            .decode(type: ClientApiResponse.self, decoder: JSONDecoder())
//            .map(Result.success)
//            .catch { error -> Just<Result<ClientApiResponse, DownloadError>> in
//                error is Decodable ? Just(.failure(.decodeError)) : Just(.failure(.decodeError))
//            }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: completion)
//            .store(in: &cancellables)
//    }
    
    func deleteClient(completion: @escaping (ClientApiResponse) -> Void) {
        var request: URLRequest = .init(url: URL(string: "\(base_url)/client")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = UserDefaults.standard.value(forKey: "allHeaderFields") as? [String : String]
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ClientApiResponse.self, decoder: JSONDecoder())
            .replaceError(with: ClientApiResponse(success: false))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
    }
    
    func getUser(completion: @escaping (ClientApiResponse) -> Void) {
        var request: URLRequest = .init(url: URL(string: "\(base_url)/client")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = UserDefaults.standard.value(forKey: "allHeaderFields") as? [String : String]
        URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
            .map(\.data)
            .decode(type: ClientApiResponse.self, decoder: JSONDecoder())
            .replaceError(with: ClientApiResponse(success: false))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
    }
}

