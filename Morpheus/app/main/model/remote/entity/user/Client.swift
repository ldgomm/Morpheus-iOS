//
//  Client.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct Client: Codable {
    let idUser: String
    var name: String
    let email: String
    let aud: String
    var userPersonalInformation: UserMainInformation? = nil
    var userProfessionalInformation: UserProfessionalInformation? = nil
    var userSystemStatusInformation: UserSystemStatusInformation? = nil
//    var timestamp: Int
}
