//
//  AuthenticationView.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import AuthenticationServices
import SwiftUI

struct AuthenticationView: View {
    
    enum SignInStatus {
        case unknown, authorized, failure(Error?)
    }
    
    @AppStorage("idUser", store: .standard) var idUser: String?
    
    @StateObject private var authenticationViewModel = AuthenticationViewModel(service: AuthenticationService())
    
    @State private var messageTitle: String = "It seems you are a new user, please sign in."
    @State private var messageBody: String = "It seems you are a new user, please sign in."
    @State private var status: SignInStatus = .unknown
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                Text(idUser ?? "You need to authenticate")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Spacer()
                VStack(alignment: .leading, spacing: 30) {
                    Text(messageTitle)
                        .font(.system(size: 45))
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    Text(messageBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                Spacer()
                SignInWithAppleButton(onRequest: onRequestSignIn, onCompletion: onCompletionSignIn)
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 55)
                    .clipShape(Capsule())
                    .padding(.horizontal, 30)
            }
        }
    }
    private func onRequestSignIn(_ request: ASAuthorizationAppleIDRequest) -> Void {
        request.requestedScopes = [.fullName, .email]
    }
    
    private func onCompletionSignIn(_ result: Result<ASAuthorization, Error>) -> Void {
        switch result {
        case .success(let auth):
            if let appleID = auth.credential as? ASAuthorizationAppleIDCredential {
                guard let appleIdToken = appleID.identityToken else {
                    print("Fail to retrieve Id token")
                    return
                }
                
                guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
                    print("Fail to retrieve Id token string")
                    return
                }
                print("Id token: \(idTokenString)")
                authenticationViewModel.validateToken(AuthenticationApiRequest(idToken: idTokenString, prime: 2))
                 
                
                //                if let fullName = appleID.fullName {
                //                    let formatter = PersonNameComponentsFormatter()
                //                    let username = formatter.string(from: fullName).trimmingCharacters(in: .whitespacesAndNewlines)
                //                    if username.isEmpty {
                //                        messageTitle = "Something went wrong, name."
                //                        UserDefaults.standard.set("user name", forKey: "username")
                //                        return
                //                    }
                //                    UserDefaults.standard.set(username, forKey: "username")
                //                }
                //                if let email = appleID.email {
                //                    if email.isEmpty {
                //                        messageBody = "Something went wrong, email."
                //                        UserDefaults.standard.set(nil, forKey: "email")
                //                        return
                //                    }
                //                    UserDefaults.standard.set(email, forKey: "email")
                //                }
                return
            }
            status = .failure(nil)
        case .failure(let error):
            if let error = error as? ASAuthorizationError {
                if error.errorCode == ASAuthorizationError.canceled.rawValue {
                    status = .unknown
                    return
                }
            }
            status = .failure(error)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
