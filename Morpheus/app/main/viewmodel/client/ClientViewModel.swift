//
//  ClientViewModel.swift
//  Morpheus
//
//  Created by José Ruiz on 12/1/23.
//

import Foundation

class ClientViewModel: ObservableObject {
    
    @Published private(set) var client: Client
    
    private let service: ClientServiceable
    
    init(service: ClientServiceable) {
        self.service = service
        self.client = Client(idUser: "init", name: "init", email: "init", aud: "init")
        
    }
    
    //    func getClient() {
    //        service.getClient { (result: Result<ClientApiResponse, DownloadError>) in
    //            switch result {
    //            case .success(let response):
    //                if response.success {
    //                    print("Client: \(String(describing: response.client))")
    //                    self.client = response.client ?? Client(idUser: "no idea", name: "no idea", email: "no idea", aud: "no idea", timestamp: 0)
    //                }
    //            case .failure(let error):
    //                print("Error downloading client: \(error.localizedDescription)")
    //                self.client = Client(idUser: "error", name: "error", email: "error", aud: "error", timestamp: 0)
    //                fatalError("Client error: \(error.localizedDescription)")
    //            }
    //        }
    //    }
    
    func getUser() {
        service.getUser { response in
            if response.success {
                print("Client: \(response.client!)")
                self.client = response.client!
            } else {
                print("Client: error!")
            }
        }
    }
    
    func deleteClient() {
        service.deleteClient { response in
            if response.success {
                UserDefaults.standard.set(nil, forKey: "idUser")
                print("Client ViewModel: Client deleted")
            }
        }
    }
}
