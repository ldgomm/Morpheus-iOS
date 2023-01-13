//
//  ClientServiceable.swift
//  Morpheus
//
//  Created by José Ruiz on 12/1/23.
//

import Foundation

protocol ClientServiceable {
    
//    func getClient(completion: @escaping (Result<ClientApiResponse, DownloadError>) -> Void) -> Void
    func getUser(completion: @escaping (ClientApiResponse) -> Void)

    func deleteClient(completion: @escaping (ClientApiResponse) -> Void)

}

enum DownloadError: Error {
    case decodeError, downloadError
}
