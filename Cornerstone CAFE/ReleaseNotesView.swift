//
//  ReleaseNotesView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/12/22.
//

import SwiftUI

struct ReleaseNotesView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading){
                Text("Release notes will show you all major updates that happend to the app. Upcoming updates to the app will also be listed down belowe as well.")
                    .foregroundColor(.secondary)
                    .font(.system(size:13))
                    .padding()
                    .padding(.bottom, 50)
                
                Text("Cornerstone current version 2.0.2") //CURRENT VERSION
                    .foregroundColor(Color.primary)
                    .padding(.horizontal)
                Text("New version new fetures, new UI redesign, and light changes to the code.")
                    .foregroundColor(.secondary)
                    .font(.system(size: 15))
                    .padding()
                    .padding(.top, 0)
                    .padding(.bottom, 50)
                
                
                
                Text("Cornerstone upcoming version 2.2") //UPCOMING VERSION
                    .foregroundColor(Color.primary)
                    .padding(.horizontal)
                Text("Next version of an app will bring advanced fetures and diffrent changes. Expact changes to Notifications as well as checking out your cart items.")
                    .foregroundColor(.secondary)
                    .font(.system(size: 15))
                    .padding()
                    .padding(.top, 0)
            }
            .padding(.top, 100)
            }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ReleaseNotesView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseNotesView()
    }
}
