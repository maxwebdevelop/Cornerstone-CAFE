//
//  CartView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CartView: View {
    @ObservedObject var monitor = NetworkConnection()
    @State private var nowifiAlert = false
    @ObservedObject var drinkVM = CartDrinkViewModuel()
    @State var totalCost = 0.00
    @State var totalCostFinall = ""
    var body: some View {
        NavigationView{
            VStack{
                //MARK: CHECK IF THE LIST OF ORDERED DRINKS IS EMPTY OR NOT
                if drinkVM.drinks.isEmpty{
                    Text("Your Cart is Empty")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                // MARK: DISPLAYS THE LIST OF ORDERED DRINKS
                List(drinkVM.drinks) { drink in
                    HStack{
                        Image(drink.drinkPicture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .cornerRadius(10)
                        
                        VStack{
                            HStack{
                                Text(drink.drinkName)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.primary)
                                    .font(.title3)
                                    .padding(.leading)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            
                            HStack{
                                HStack{
                                    Text("Size: ")
                                        .foregroundColor(Color.secondary)
                                    Text(drink.drinkSize)
                                }
                                Spacer()
                                HStack{
                                    if drink.drinkExtraShot != 0{
                                        Text("Extra shots: ")
                                            .foregroundColor(Color.secondary)
                                        Text("\(drink.drinkExtraShot)")
                                            .foregroundColor(Color.primary)
                                            .padding(.trailing)
                                    }
                                }
                            }
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            
                            VStack{
                                HStack{
                                    HStack{
                                        Text("Price: ")
                                            .foregroundColor(Color.secondary)
                                        Text("$ " + "\(drink.drinkCost)")
                                    }
                                    Spacer()
                                    if drink.drinkCondition != ""{
                                            HStack{
                                            Text("Type: ")
                                            
                                            Text(drink.drinkCondition)
                                                .padding(.trailing)
                                                .foregroundColor(Color.secondary)
                                        }
                                        Spacer()
                                    }
                                }
                                
                            }.frame(maxWidth: .infinity)
                        }
                        .padding(.leading)
                    }
                    .swipeActions{ //MARK: THIS IS A SWIPE ACTION TO DELETE THE CHOSEN ITEM FROM THE LIST
                        Button(role: .destructive){
                            drinkVM.deleteDate(drinkToDelete: drink)
                        }label: {
                            Image(systemName: "minus.circle")
                        }
                    }
                    
                    //MARK: THIS IS ALERT THAT WILL POP UP WHEN THERE WONT BE ANY WIFI
                    .alert(isPresented: $nowifiAlert){
                        Alert(title: Text("NO WIFI"), message: Text("Please connect your device to wifi."), dismissButton:
                                .destructive(Text("OK")))
                    }
                }
                .onAppear{ // MARK: THIS WILL DISPLAY THE TOTAL PRICE OF ALL OF THE DRINKS COMBINED
                    totalCost = 0.00
                    for drink in drinkVM.drinks{
                        totalCost += drink.drinkCost
                        // remove extra 4 zeros after te decimal
                        totalCost = Double(String(format: "%.2f", totalCost))!
                        totalCostFinall = "\(totalCost)"
                    }
                }
                
                
                VStack{
                    HStack{
                        Spacer()
                        Text("Total: ")
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                    
                        Text("\(totalCostFinall)")
                            .foregroundColor(Color.primary)
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            Text("Order")
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
                        
                        
                        Spacer()
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Cart")
            .onAppear{
                drinkVM.fetchDrinks()
                
                if monitor.isConnected == false {
                    nowifiAlert.toggle()
                }
                
                totalCost = 0.00
                for drink in drinkVM.drinks{
                    totalCost += drink.drinkCost
                    // remove extra 4 zeros after te decimal
                    totalCost = Double(String(format: "%.2f", totalCost))!
                    totalCostFinall = "\(totalCost)"
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .refreshable{
            drinkVM.fetchDrinks()
            totalCost = 0.00
            for drink in drinkVM.drinks{
                totalCost += drink.drinkCost
                // remove extra 4 zeros after te decimal
                totalCost = Double(String(format: "%.2f", totalCost))!
                totalCostFinall = "\(totalCost)"
            }
        }
    }
    init(){
        drinkVM.fetchDrinks()
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
