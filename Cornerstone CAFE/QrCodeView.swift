//
//  QrCodeView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase
import CoreImage
import CoreImage.CIFilterBuiltins

struct QrCodeView: View {
    @ObservedObject var monitor = NetworkConnection()
    @State private var usersEmail = Auth.auth().currentUser?.uid ?? ""
    @State private var nowifiAlert = false
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("Scan your QR code to receive your rewards for shoping with us. Purchase 9 drinks and the 10th drink is on us.")
                    .foregroundColor(Color.secondary)
                    .padding(.horizontal)
                    .font(.system(size: 15))
                    .padding(.bottom, 50)

                
                
                Image(uiImage: genetateQRCode(from: "\(String(describing: usersEmail))"))
                    .interpolation(.none)
                    .resizable()
                    .scaleEffect()
                    .frame(width: 200, height: 200)
                
                Spacer()
                NavigationLink("Need help?", destination: QrCodeNeedHelp())
                    .foregroundColor(Color.secondary)
                    .padding(.bottom, 50)
                
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
    
    func genetateQRCode(from string: String) -> UIImage{
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage{
            if let cgimage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}

struct QrCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeView()
    }
}
