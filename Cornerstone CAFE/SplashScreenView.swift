//
//  SplashScreenView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/19/22.
//

import SwiftUI

struct PageView: View{
    let title: String
    let message: String
    let imgName: String
    let showDismissButton: Bool
    @Binding var shouldShowOnBoarding:Bool
    var body: some View{
        VStack{
            Image(imgName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 130)
                .padding()
                .padding(.bottom)
            
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(Color.secondary)
                .padding(.horizontal)
                .font(.title)
                .padding(.bottom)
            
            Text(message)
                .foregroundColor(Color.secondary)
                .padding(.horizontal)
                .padding(.bottom, 50)
            
            if showDismissButton{
                Button{
                    shouldShowOnBoarding.toggle()
                }label: {
                    Text("Get started")
                        .frame(minWidth: 0, maxWidth: 200)
                        .font(.system(size: 20))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }// If you have this
                .cornerRadius(25)
                .padding(.top, 35)
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
       LoginView()
    }
}
