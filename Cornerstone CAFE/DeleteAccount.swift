//
//  DeleteAccount.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/16/22.
//

import SwiftUI
import Firebase

struct DeleteAccount: View {
    @State private var errrrroooorrrr = ""
    @State private var isUserAuthenticated = true
    @State private var errorDeletingTheAccount = ""
    var body: some View {
        
        if isUserAuthenticated {
            RemovingAccountView
        }else{
            LoginView()
        }
    
    }
    
    var RemovingAccountView: some View {
        VStack{
            Text("Deleting your account will make you loose all your information and  you will have to re-register for a new account next time.")
                .foregroundColor(Color.secondary)
                .padding(.horizontal)
                .padding(.top, 100)
            
            Text(errorDeletingTheAccount)
                .foregroundColor(Color("LightRed"))
                .padding(.bottom, 100)
                .padding(.top, 100)
                .padding(.horizontal)
            Button{
                deleteUsersAccount()
            }label: {
                Text("DELETE ACCOUT")
                    .foregroundColor(Color.red)
            }
            Spacer()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func deleteUsersAccount(){
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                errorDeletingTheAccount = error.localizedDescription
                print(error.localizedDescription)
            } else {
                Auth.auth().addStateDidChangeListener{ auth, user in
                    if user == nil{
                        isUserAuthenticated.toggle()
                    }
                }
            }
        }
    }

}
struct DeleteAccount_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccount()
    }
}
