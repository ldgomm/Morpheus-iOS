//
//  ProfileView.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("idUser", store: .standard) var idUser: String?

    @AppStorage("username", store: .standard) var username: String?
    @AppStorage("email", store: .standard) var email: String?
    
    @StateObject private var authenticationViewModel = AuthenticationViewModel(service: AuthenticationService())
    
    var body: some View {
        VStack {
            Text(idUser ?? "Something happened")
            Text(authenticationViewModel.response.client?.idUser ?? "No user")
            Button("Delete user", action: deleteUser)
        }
        .onAppear {
            getUser()
        }
        
    }
    
    func getUser() {
        Task {
            authenticationViewModel.getUser()
        }
    }
    
    func deleteUser() {
        authenticationViewModel.deleteUser()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
