//
//  LoginView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @AppStorage("shouldShowOnBoarding") var shouldShowOnBoarding: Bool = true
    @ObservedObject var monitor = NetworkConnection()
    @State private var textSwitch = false
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
                
                Text("Hello")
                    .foregroundColor(Color.primary)
                    .fontWeight(.bold)
                    .font(.system(size: 70))
                
                Text("Sign in to your account")
                    .foregroundColor(Color.primary)
                    .fontWeight(.light)
                    .font(.system(size: 20))
                //Displaying Error
                VStack{
                    Text(errrrrroooorrr)
                        .foregroundColor(Color("LightRed"))
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .padding(.bottom, 30)
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
                    .padding(.top, 35)
                    .padding(.horizontal)
                    
                    //Link to forgot password view
                    NavigationLink("Forgot password?", destination: ForgotpasswordView())
                        .foregroundColor(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                        .padding(.top)
                    
                    Button{
                        loginUser()
                    }label: {
                        Text("Login")
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
                    
                    
                    NavigationLink("Don't have an account? Register", destination: RegisterView())
                        .padding(.top, 20)
                        .foregroundColor(Color.secondary)
                
                
                        .alert(isPresented: $nowifiAlert){
                            Alert(title: Text("NO WIFI"), message: Text("Please connect your device to wifi."), dismissButton: .destructive(Text("OK")))
                        }
                }// End of a VStack
            }// End of a NavigationView
            .fullScreenCover(isPresented: $shouldShowOnBoarding, content: {
                SplashScreenView(shouldShowOnBoarding: $shouldShowOnBoarding)
            }
            )
            
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
        func loginUser(){
            Auth.auth().signIn(withEmail: email, password: password){ result, error in
                if error != nil{
                    errrrrroooorrr = error!.localizedDescription
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        errrrrroooorrr = " "
                    }
                }
            }
        }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.light)
    }
}
