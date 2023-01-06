//
//  Offer.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct Offer: Codable {
    var idOffer: String = UUID().uuidString
    var title: String
    var area: String
    var schedule: String
    var modality: String
    var location: String
    var description: String
    var preparation: Preparation? = nil
    var benefits: [Benefit]? = nil
    var wageRange: WageRange? = nil
    var details: [Detail]? = nil
    var publisher: String? = nil
    var consumers: [String]? = nil
    var timestamp: Int64 = Int64(Date().timeIntervalSince1970)
}
