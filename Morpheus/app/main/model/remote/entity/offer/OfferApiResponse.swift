//
//  OfferApiResponse.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct OfferApiResponse: Codable {
    var success: Bool = false
    var message: String? = nil
    var offer: Offer? = nil
    var offers: [Offer]? = nil
}
