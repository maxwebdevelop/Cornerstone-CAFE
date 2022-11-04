//
//  PushNotificationsView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/12/22.
//

import SwiftUI

struct PushNotificationsView: View {
    var body: some View {
        VStack{
            Text("Sorry, we are currently updating this page. This will be avaiable in the future versions of the app.")
                .foregroundColor(Color("LightRed"))
                .padding()
                .font(.system(size: 15))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PushNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        PushNotificationsView()
    }
}
