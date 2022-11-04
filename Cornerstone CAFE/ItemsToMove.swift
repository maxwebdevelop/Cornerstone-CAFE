//
//  ItemsToMove.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/15/22.
//

import SwiftUI
import Firebase

struct ItemsToMove: View {
    @State private var isUserAuthenticated = true
    var body: some View {
        if isUserAuthenticated{
            ItemsBodyToMove
        }else{
            LoginView()
        }
    }
    
    var ItemsBodyToMove: some View{
    TabView{
        HomeView()
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
        
        QrCodeView()
            .tabItem {
                Image(systemName: "qrcode")
                Text("QR Code")
            }
        
        OrderView()
            .tabItem {
                Image(systemName: "menucard")
                Text("Order")
            }
        
        CartView()
            .tabItem {
                Image(systemName: "cart")
                Text("Cart")
            }
        
        SettingsView()
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
    }
    .accentColor(Color.primary)
    .onAppear{
        Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                isUserAuthenticated.toggle()
            }
        }
    }
    
}
}

struct ItemsToMove_Previews: PreviewProvider {
    static var previews: some View {
        ItemsToMove()
    }
}
