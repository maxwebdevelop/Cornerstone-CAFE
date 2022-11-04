//
//  HomeView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    @ObservedObject var monitor = NetworkConnection()
    @State private var isUserAuthenticated = true
    @State private var nowifiAlert = false
    @State var displayGreeting = ""
    @State var numberTotal = "NA"
    @State var numberHave = "NA"
    @State var displayUsersName = ""
    @State var displayRandomNumber1 = " "
    @State var displayRandomNumber2 = " "
    @State var displayRandomNumber3 = " "
    @State private var name = Auth.auth().currentUser?.displayName ?? "User"
    @ObservedObject var viewModel = RecommandDrinksModule()
    var body: some View{
        if isUserAuthenticated{
            homeBodyView
        }else{
            LoginView()
        }
    }// end of a homeview
    
    var homeBodyView: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    // Vstack for greeting
                    VStack{
                        Text(displayGreeting)
                            .fontWeight(.regular)
                            .foregroundColor(Color.secondary)
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        Text(displayUsersName)
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .font(.system(size: 40))
                            .foregroundColor(Color.primary)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.bottom, 25)
                    
                    
                    
                    
                    VStack{
                        // displays the total number f coffees till the ext free one
                        HStack{
                            Text("Free coffee")
                                .foregroundColor(Color.black)
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                            Spacer()
                            Text(numberHave)
                                .foregroundColor(Color.black)
                                .fontWeight(.bold)
                            Text("/")
                                .foregroundColor(Color.black)
                                .fontWeight(.bold)
                            Text(numberTotal)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        
                        // visual effect of the coffee
                        HStack{
                            Text("This section is still being worked on.")
                                .foregroundColor(Color.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.top)

                    }
                    .padding(.vertical, 25)
                    .background(Color("LightGray"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    
                    
                    
                    
                    VStack{
                        Text("Recomendations")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(viewModel.OnlyOneDrinkData) {drink in
                                    let randomInt1 = Int.random(in: 0..<13)
                                    if drink.drinkNumber < randomInt1{
                                        VStack{
                                            // Displays image for the drink
                                            Image(drink.DrinkImageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 200, height: 200)
                                                .cornerRadius(10)
                                            
                                            // Displays text for the drink
                                            Text("\(drink.DrinkName)")
                                                .foregroundColor(Color.primary)
                                                .fontWeight(.bold)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.leading)
                                            
                                            Text("\(drink.DrinkDescription)")
                                                .foregroundColor(Color.primary)
                                                .fontWeight(.light)
                                                .frame(width: 200, alignment: .leading)
                                                .padding(.leading)
                                                .lineLimit(3)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 5)
                        
                        .alert(isPresented: $nowifiAlert){
                            Alert(title: Text("NO WIFI"), message: Text("Please connect your device to wifi."), dismissButton: .destructive(Text("OK")))
                        }
                    }
                    .padding(.top, 25)
                    
                    
                    
                    VStack{
                        Image("orderahead")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                        
                        Text("Order ahead!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 15)
                        
                        Text("Skip the line and order online. Open the app, order, then just come and pick it up.")
                            .fontWeight(.light)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 1)
                            .padding(.bottom, 35)
                    }
                    .padding(.top, 35)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .refreshable {
                    getGreetersName()
                }
            }// END OF A NAVIGATION VIEW
            
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear{
                // This moniters the auth state of the user
                Auth.auth().addStateDidChangeListener{ auth, user in
                    if user == nil{
                        isUserAuthenticated.toggle()
                    }
                }
                
                // This moniters the internet connection
                if monitor.isConnected == false {
                    nowifiAlert.toggle()
                }
                
                // Displays the function for a greeting
                getGreeting()
                getGreetersName()
            }
        }
    }
        
        // function that will dispaly greetings depending on a time
        func getGreeting() -> String {
            let hour = Calendar.current.component(.hour, from: Date())
            
            switch hour {
            case 0..<4:
                displayGreeting = "Hello"
            case 4..<12:
                displayGreeting = "Good morning"
            case 12..<18:
                displayGreeting = "Good afternoon"
            case 18..<24:
                displayGreeting = "Good evening"
            default:
                break
            }
            return "Hello"
        }
        
        
        func getGreetersName(){
            if Auth.auth().currentUser != nil {
                // User is signed in.
                let user = Auth.auth().currentUser
                if let user = user {
                    let usersName = user.displayName
                    
                    if usersName != nil{
                        displayUsersName = usersName ?? ""
                    }else{
                        displayUsersName = "User"
                    }
                }
            } else {
                // No user is signed in.
                // ...
            }
        }
    }
    

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
