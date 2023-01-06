//
//  UserSystemStatusInformation.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct UserSystemStatusInformation: Codable {
    let isValidated: Bool = false
    let isActive: Bool = true
    let isSuspended: Bool = false
    let isBlocked: Bool = false
}
