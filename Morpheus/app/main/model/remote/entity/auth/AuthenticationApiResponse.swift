//
//  AuthenticationApiResponse.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct AuthenticationApiResponse: Codable {
    var success: Bool
    var message: String? = nil
    var client: Client? = nil
    var partner: Partner? = nil
}
