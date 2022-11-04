//
//  RegisterView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @ObservedObject var monitor = NetworkConnection()
    @State private var isUserAuthenticated = false
    @State private var email = ""
    @State private var password = ""
    @State private var nowifiAlert = false
    @State private var errrrrroooorrr = ""
    var body: some View {
        if isUserAuthenticated{
            ItemsToMove()
        }else{
            LoginViewBody
        }
    }
    
    
    var LoginViewBody: some View{
        NavigationView{
            VStack{
                Text("Create an account")
                    .font(.system(size: 35))
                    .foregroundColor(Color.primary)
                    .fontWeight(.bold)
                //VStaack for displaying alert
                VStack{
                    Text(errrrrroooorrr)
                        .padding(.top, 10)
                        .padding(.horizontal)
                        .foregroundColor(Color("LightRed"))
                }
                
                //HStack for email Field
                VStack{
                    TextField("Email", text: $email)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.primary, style: StrokeStyle(lineWidth: 1.0)))
                        .foregroundColor(Color.primary)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                //HStack for password Field
                VStack{
                    SecureField("Password", text: $password)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.primary, style: StrokeStyle(lineWidth: 1.0)))
                        .foregroundColor(Color.primary)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.top, 30)
                .padding(.horizontal)
                
                Button{
                    registeringUser()
                }label: {
                    Text("Register")
                        .frame(minWidth: 0, maxWidth: 200)
                        .font(.system(size: 20))
                        .padding()
                        .foregroundColor(.primary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.primary, lineWidth: 1)
                    )
                }// If you have this
                .cornerRadius(25)
                .padding(.top, 35)
                
                
                //Alerts to display for errors
                .alert(isPresented: $nowifiAlert){
                    Alert(title: Text("NO WIFI"), message: Text("Please connect your device to wifi."), dismissButton: .destructive(Text("OK")))
                }
            }// End of a VStack
            .offset(y: -40)
            .frame(maxWidth: .infinity)
//            .navigationBarTitleDisplayMode(.inline)
        }// End of a NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            if monitor.isConnected == false {
                nowifiAlert.toggle()
            }
            Auth.auth().addStateDidChangeListener{ auth, user in
                if user != nil{
                    isUserAuthenticated.toggle()
                }
            }
        }
    }
    
    //Sign people in function
    func registeringUser(){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if error != nil{
                errrrrroooorrr = error!.localizedDescription
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    errrrrroooorrr = " "
                }
            }
        }
    }
    
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
