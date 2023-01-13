//
//  ClientApiResponse.swift
//  Morpheus
//
//  Created by José Ruiz on 12/1/23.
//

import Foundation

struct ClientApiResponse: Codable {
    var success: Bool
    var message: String? = nil
    var client: Client? = nil
}
