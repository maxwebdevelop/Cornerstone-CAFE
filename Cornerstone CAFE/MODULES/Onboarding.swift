//
//  Onboarding.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/19/22.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    @Binding var shouldShowOnBoarding: Bool
    var body: some View {
        TabView{
            PageView(title: "Push Notifications", message: "Turn on your push notifications and get notified on any new events/updates.", imgName: "notificationss", showDismissButton: false, shouldShowOnBoarding: $shouldShowOnBoarding)
            PageView(title: "Search and Report", message: "Since this app is still in the early versions, please report and let us know of any bugs/glitches that you may find.", imgName: "search", showDismissButton: false, shouldShowOnBoarding: $shouldShowOnBoarding)
            PageView(title: "Review and Share", message: "Don't forget to leave a review and share with your friend", imgName: "reviewStar", showDismissButton: true, shouldShowOnBoarding: $shouldShowOnBoarding)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

