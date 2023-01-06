//
//  AuthenticationServiceable.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

protocol AuthenticationServiceable {
    func getUser(completion: @escaping (AuthenticationApiResponse) -> Void)
    
    func validateToken(_ authenticationApiRequest: AuthenticationApiRequest, completion: @escaping (Result<AuthenticationApiResponse, UploadError>) -> Void) -> Void
    
    func deleteUser(completion: @escaping (AuthenticationApiResponse) -> Void)
}

enum UploadError: Error {
    case decodeError, uploadError
}
