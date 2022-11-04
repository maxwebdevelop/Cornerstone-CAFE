//
//  SettingsView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    @ObservedObject var monitor = NetworkConnection()
    @State private var nowifiAlert = false
    @State private var isUserAuthenticated = true
    var body: some View {
        if isUserAuthenticated {
            settingsBodyView
        } else {
            LoginView()
        }
    }
    
    var settingsBodyView: some View{
        NavigationView{
            VStack{
                List{
                    HStack{
                        Text("App name:")
                        
                        Text("Cornerstone CAFE")
                            .padding(.horizontal, 30)
                            .foregroundColor(Color.secondary)
                    }
                    
                    HStack{
                        Text("App version:")
                        
                        Text("2.0.2")
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.secondary)
                    }
                    
                    HStack{
                        Image(systemName: "note.text")
                        
                        NavigationLink("Release notes", destination: ReleaseNotesView())
                            .foregroundColor(Color.primary)
                        }
                    
                    
                    HStack{
                        Image(systemName: "app.badge")
                        
                        NavigationLink("Push Notifications", destination: PushNotificationsView())
                            .foregroundColor(Color.primary)
                    }
                    
                    HStack{
                        Image(systemName: "person")
                        
                        NavigationLink("Edt Profile", destination: EditProfileView())
                            .foregroundColor(Color.primary)
                    }
                    
                    HStack{
                        Image(systemName: "person.crop.circle")
                        
                        NavigationLink("Manage Account", destination: DeleteAccount())
                            .foregroundColor(Color.primary)
                    }
                    
                    Button{
                        logUserOut()
                    }label: {
                        Text("Log out")
                            .foregroundColor(Color("LightRed"))
                    }
                    
                    }
                
                    .alert(isPresented: $nowifiAlert){
                        Alert(title: Text("NO WIFI"), message: Text("Please connect your device to wifi."), dismissButton:
                            .destructive(Text("OK")))
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            if monitor.isConnected == false {
                nowifiAlert.toggle()
            }
        }
        }
    
    func logUserOut(){
        do{
            try Auth.auth().signOut()
            isUserAuthenticated.toggle()
        }catch{
            print("already logged out")
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
