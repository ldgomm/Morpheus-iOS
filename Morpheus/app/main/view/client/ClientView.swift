//
//  ProfileView.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import SwiftUI

struct ClientView: View {
    @AppStorage("idUser", store: .standard) var idUser: String?
    
    //    @AppStorage("username", store: .standard) var username: String?
    //    @AppStorage("email", store: .standard) var email: String?
    
    @StateObject private var clientViewModel: ClientViewModel
        
    var body: some View {
        VStack {
            Text(idUser ?? "Something happened")
            Button("Get client", action: getClient)
                .buttonStyle(.borderedProminent)
            Button("Delete client", action: deleteUser)
        }.onAppear(perform: getClient)
    }
    
    func getClient() {
        Task {
            clientViewModel.getUser()
        }
    }
    
    func deleteUser() {
        clientViewModel.deleteClient()
    }
    
    init(clientServiceable: ClientServiceable = ClientService()) {
        _clientViewModel = StateObject(wrappedValue: ClientViewModel(service: clientServiceable))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ClientView()
    }
}
