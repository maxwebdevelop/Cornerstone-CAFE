//
//  QrCodeNeedHelp.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/12/22.
//

import SwiftUI

struct QrCodeNeedHelp: View {
    @ObservedObject var monitor = NetworkConnection()
    @State private var nowifiAlert = false
    var body: some View {
        VStack{
            Text("If you are having troubles with your QR code, please try the following steps to fix the issue.")
                .foregroundColor(Color.secondary)
                .font(.system(size: 18))
                .padding(.bottom, 80)
                .padding(.horizontal)
            
            Text("1. Check your personal Wi-Fi connection.")
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundColor(Color.primary)
            Text("2. Close and re-open the app. Try again.")
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundColor(Color.primary)
            Text("3. Log out from your account and log back in.")
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundColor(Color.primary)
            Text("4. Try to re-install the app.")
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundColor(Color.primary)
            
            
                .alert(isPresented: $nowifiAlert){
                    Alert(title: Text("NO WIFI"), message: Text("Please connect your device to wifi."), dismissButton:
                            .destructive(Text("OK")))
                }
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            if monitor.isConnected == false {
                nowifiAlert.toggle()
            }
        }
    }
}

struct QrCodeNeedHelp_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeNeedHelp()
    }
}
