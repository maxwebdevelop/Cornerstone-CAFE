//
//  Cornerstone_CAFEApp.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase

@main
struct Cornerstone_CAFEApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup{
            LoginView()
            }
        }
    }
