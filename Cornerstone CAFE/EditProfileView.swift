//
//  EditProfileView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/12/22.
//

import SwiftUI
import Firebase

struct EditProfileView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var errrrrooorrr = ""
    @State private var errrrrooorrreee = ""
    @State private var successseee = ""
    @State private var successName = " "
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                Text("The information provided below is only used for your personal orders.")
                    .font(.system(size: 18))
                    .foregroundColor(Color.secondary)
                    .padding(.horizontal)
                Text(errrrrooorrr)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .foregroundColor(Color("LightRed"))
                    .padding(.top)
                Text(successName)
                    .padding(.horizontal)
                    .foregroundColor(Color.green)
                    .padding(.bottom, 10)
                
                TextField("Full name", text: $fullName)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.primary, style: StrokeStyle(lineWidth: 1.0)))
                    .foregroundColor(Color.primary)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                
                
                Button{
                    editName()
                }label:{
                    Text("Edit name")
                        .frame(minWidth: 0, maxWidth: 200)
                        .font(.system(size: 20))
                        .padding()
                        .foregroundColor(.primary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.primary, lineWidth: 1)
                        )
                }
                .cornerRadius(25)
                .padding(.top, 30)
            }
            .padding(.top, 50)
            
            
            VStack{
                Text("This will send you a reset password link to the email that you provide down below.")
                    .foregroundColor(Color.secondary)
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                Text(errrrrooorrreee)
                    .padding(.horizontal)
                    .foregroundColor(Color.red)
                    .padding(.bottom)
                
                Text(successseee)
                    .padding(.horizontal)
                    .foregroundColor(Color.green)
                    .padding(.bottom, 10)
                
                TextField("Email adress", text: $email)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.primary, style: StrokeStyle(lineWidth: 1.0)))
                    .foregroundColor(Color.primary)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                
                
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
                .cornerRadius(25)
                .padding(.top, 30)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 100)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    func editName(){
        if Auth.auth().currentUser != nil{
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = fullName
            changeRequest?.commitChanges { error in
                if fullName == ""{
                    errrrrooorrr = "Imput field is empty"
                    successName = ""
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        errrrrooorrr = " "
                    }
                }else if error != nil {
                    errrrrooorrr = error!.localizedDescription
                    print(error!.localizedDescription)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        errrrrooorrr = " "
                    }
                }
                else {
                    errrrrooorrr = ""
                    fullName = ""
                    successName = "Your name has been successfully changed"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        successName = " "
                    }
                }
            }
        }
    }
    
    
    func sendPasswordReset(){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if error != nil{
                errrrrooorrreee = error!.localizedDescription
                successseee = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    errrrrooorrreee = " "
                }
            } else {
                successseee = "Successfully sent, please check your email for the password reset"
                email = ""
                errrrrooorrreee = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    successseee = " "
                }
            }
        }
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
