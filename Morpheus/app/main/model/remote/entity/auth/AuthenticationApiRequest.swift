//
//  AuthenticationApiRequest.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct AuthenticationApiRequest: Codable {
    let idToken: String
    let prime: Int
}
