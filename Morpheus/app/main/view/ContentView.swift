//
//  ContentView.swift
//  Morpheus
//
//  Created by José Ruiz on 2/1/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("idUser", store: .standard) var idUser: String?
    let ud = UserDefaults.standard.value(forKey: "allHeaderFields") as? [String : String]

    var body: some View {
        NavigationStack {
            if idUser == nil {
                AuthenticationView()
            } else {
                ClientView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
