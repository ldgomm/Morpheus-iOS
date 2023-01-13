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
    
    func validateToken(_ authenticationApiRequest: AuthenticationApiRequest, completion: @escaping (Result<AuthenticationApiResponse, UploadError>) -> Void) -> Void {
        var request: URLRequest = .init(url: URL(string: "\(base_url)/apple_token_verification")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(authenticationApiRequest)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
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
}
