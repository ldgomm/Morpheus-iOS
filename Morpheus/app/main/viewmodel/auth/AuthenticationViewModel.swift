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
                print("Response: \(response)")
                self.isAuthenticated = response.success
                if response.success {
                    UserDefaults.standard.set("User", forKey: "idUser")
                }
                print("Is authenticated (response): \(self.isAuthenticated)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.isAuthenticated = false
                fatalError()
            }
        }
    }
    
    func getUser() {
        service.getUser { response in
            self.response = response
        }
    }
    
    func deleteUser() {
        service.deleteUser { response in
            print("AuthenticationViewModel: user deleted")
        }
    }
}
