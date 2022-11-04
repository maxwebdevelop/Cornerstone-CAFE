//
//  ForgotpasswordView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ForgotpasswordView: View {
    @ObservedObject var monitor = NetworkConnection()
    @State private var email = ""
    @State private var successSend = ""
    @State private var nowifiAlert = false
    @State private var errrrrroooorrr = ""
    var body: some View {
        NavigationView{
            VStack{
                // VStack for Text
                Text("Reset account password")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 30)

                VStack(alignment: .leading, spacing: 10){
                    Text("This will send you a reset password link to the email that you provide down below.")
                        .foregroundColor(Color.secondary)
                        .font(.system(size: 15))
                        .padding(.horizontal)
                        .padding(.bottom)
                        .lineLimit(5)
                        .padding(.top, 20)
                    
                    Text(errrrrroooorrr)
                        .foregroundColor(Color("LightRed"))
                        .font(.system(size: 15))
                        .padding()
                        .padding(.top)
                    
                    Text(successSend)
                        .foregroundColor(Color.green)
                        .font(.system(size: 15))
                        .padding()
                        .padding(.top)
                }
                //VStack for input
                VStack{
                    TextField("Email", text: $email)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.primary, style: StrokeStyle(lineWidth: 1.0)))
                        .foregroundColor(Color.primary)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                Button{
                    sendPasswordReset()
                }label: {
                    Text("Reset password")
                        .frame(minWidth: 0, maxWidth: 200)
                        .font(.system(size: 20))
                        .padding()
                        .foregroundColor(.primary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.primary, lineWidth: 1)
                            )
                }
                .padding(.top, 35)
 
                
                
                .alert(isPresented: $nowifiAlert){
                    Alert(title: Text("NO WIFI"), message: Text("Please connect your device to wifi."), dismissButton: .destructive(Text("OK")))
                }
            }// End of a VStack
            .offset(y: -100)
        }// End of a Navigation view
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            if monitor.isConnected == false {
                nowifiAlert.toggle()
            }
        }
    }
    
    func sendPasswordReset(){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if error != nil{
                errrrrroooorrr = error!.localizedDescription
            } else {
                successSend = "Successfully sent, please check your email for the password reset"
                email = ""
                errrrrroooorrr = ""
            }
        }
    }
}

struct ForgotpasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotpasswordView()
    }
}
