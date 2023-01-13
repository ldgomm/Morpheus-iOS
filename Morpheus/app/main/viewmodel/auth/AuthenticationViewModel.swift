//
//  AuthenticationViewModel.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published private(set) var isAuthenticated: Bool
    @Published private(set) var response: AuthenticationApiResponse
    
    private let service: AuthenticationServiceable
    
    init(service: AuthenticationServiceable) {
        self.service = service
        self.isAuthenticated = false
        
        self.response = AuthenticationApiResponse(success: false)
        
    }
    
    func validateToken(_ authenticationApiRequest: AuthenticationApiRequest) {
        service.validateToken(authenticationApiRequest) { (result: Result<AuthenticationApiResponse, UploadError>) in
            switch result {
            case .success(let response):
                print("Authentication response: \(response)")
                self.isAuthenticated = response.success
                if response.success {
                    UserDefaults.standard.set(response.client?.idUser ?? "User-\(Int.random(in: 1000...9999))", forKey: "idUser")
                }
                print("Authentication, is auth: \(self.isAuthenticated)")
            case .failure(let error):
                print("Authentication error: \(error.localizedDescription)")
                self.isAuthenticated = false
                fatalError()
            }
        }
    }
}
