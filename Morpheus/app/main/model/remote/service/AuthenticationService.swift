//
//  AuthenticationService.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Combine
import Foundation

class AuthenticationService: AuthenticationServiceable {
    
    private var cancellables: Set<AnyCancellable>
    
    init() {
        cancellables = []
    }
    
    func getUser(completion: @escaping (AuthenticationApiResponse) -> Void) {
        var request: URLRequest = .init(url: URL(string: "\(base_url)/client")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = UserDefaults.standard.value(forKey: "allHeaderFields") as? [String : String]
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: AuthenticationApiResponse.self, decoder: JSONDecoder())
            .replaceError(with: AuthenticationApiResponse(success: false))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
    }
    
    func validateToken(_ authenticationApiRequest: AuthenticationApiRequest, completion: @escaping (Result<AuthenticationApiResponse, UploadError>) -> Void) -> Void {
        var request: URLRequest = .init(url: URL(string: "\(base_url)/apple_token_verification")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(authenticationApiRequest)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                print("Data: \(data)")
                let res = response as? HTTPURLResponse
                UserDefaults.standard.set(res?.allHeaderFields, forKey: "allHeaderFields")
                
                guard let httpResponse  = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: AuthenticationApiResponse.self, decoder: JSONDecoder())
            .map(Result.success)
            .catch { error -> Just<Result<AuthenticationApiResponse, UploadError>> in
                error is Decodable ? Just(.failure(.decodeError)) : Just(.failure(.uploadError))
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
        
    }
    
    func deleteUser(completion: @escaping (AuthenticationApiResponse) -> Void) {
        var request: URLRequest = .init(url: URL(string: "\(base_url)/user")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = UserDefaults.standard.value(forKey: "allHeaderFields") as? [String : String]
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: AuthenticationApiResponse.self, decoder: JSONDecoder())
            .replaceError(with: AuthenticationApiResponse(success: false))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
    }
}
