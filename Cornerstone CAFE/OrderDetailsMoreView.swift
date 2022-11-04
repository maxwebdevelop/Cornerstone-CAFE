//
//  OrderDetailsMoreView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct OrderDetailsMoreView: View {
    @ObservedObject var monitor = NetworkConnection()
    @State private var nowifiAlert = false
    var items: [OneDrink] = DrinkList.drinkData
    var item: OneDrink
    @State var selection: String = ""
    let drinkSize: [String] = [
        "8 oz", "12 oz", "16 oz", "20 oz"
    ]
    
    @State var selection3: String = ""
    let drinkSize3: [String] = [
        "12 oz", "16 oz", "20 oz"
    ]
    
    @State var selection2: String = ""
    let drinkCondition: [String] = [
        "Hot", "Iced"
    ]
    
    @State private var extraShots = 0
    @State var drinkPrice: Double
    @State var exTraShotPrice: Double
    @State private var successAlert = ""
    @State private var errorAlert = ""
    @State private var errorAlert2 = ""
    @State private var successAlert2 = ""
    @State var finalDrinkPrice2 = ""
    @State var notifyThatSizeisEmpty = false
    @State private var notifyThatTheConditionisEmpty = false
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        Image(item.DrinkImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .opacity(0.9)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        if item.isAvailable != true{
                            VStack{
                                Text("NOT AVAILABLE")
                                    .foregroundColor(Color.white)
                                    .frame(width: 130, height: 30)
                                    .padding(.horizontal)
                            }
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                        }
                        
                        Text(item.DrinkName)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.bottom)
                        if item.DrinkDescription == ""{
                            Text("No description provided")
                                .foregroundColor(Color.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }else{
                            Text(item.DrinkDescription)
                                .foregroundColor(Color.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .padding(.bottom, 30)
                        }
                        
                        
                        //MARK: Checking if the the drink name is that, then aplying all of the stuff needded for it
                        if item.DrinkIsCoffee == true || item.DrinkName == "Tea" || item.DrinkName == "Vanilla Chai Tea" || item.DrinkName == "Hot Chocolate"{
                            VStack{
                                //MARK: If this is coffee make a picker for the sizes
                                HStack{
                                    Text("Drink size")
                                        .foregroundColor(Color.primary)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                    Spacer()
                                    Text("Required")
                                        .foregroundColor(Color.red)
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .padding(.bottom)
                                
                                // MARK: Drink size picker Goes here
                                Picker(
                                    selection: $selection,
                                    label: Text("Picker"),
                                    content:{
                                        ForEach(drinkSize.indices){index in
                                            Text(drinkSize[index])
                                                .tag(drinkSize[index])
                                        }.onChange(of: selection) { newValue in
                                            TotalPricePerItem()
                                        }
                                    }
                                )
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.horizontal)
                                .padding(.bottom)
                            }//MARK: END OF A VSTACK
                            
                            // MARK: check if the drink can be iether cold or hot
                            if item.DrinkCanBeIced == true{
                                VStack{
                                    HStack{
                                        Text("Drink condition")
                                            .foregroundColor(Color.primary)
                                            .fontWeight(.bold)
                                            .font(.title2)
                                        Spacer()
                                        Text("Required")
                                            .foregroundColor(Color.red)
                                        
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                    .padding(.top)
                                    
                                    Picker(
                                        selection: $selection2,
                                        label: Text("Picker"),
                                        content:{
                                            ForEach(drinkCondition.indices){ index in
                                                Text(drinkCondition[index])
                                                    .tag(drinkCondition[index])
                                            }
                                        })
                                    .pickerStyle(SegmentedPickerStyle())
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                }//MARK: END OF A VSTACK
                            }
                            
                            if item.DrinkName != "Tea" && item.DrinkName != "Americano" && item.DrinkName != "Hot Chocolate" && item.DrinkName != "Steamer" && item.DrinkName != "London Fog" && item.DrinkName != "Cappucchino"{
                                VStack{
                                    Text("Optional")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.trailing)
                                        .foregroundColor(Color.secondary)
                                        .padding(.bottom, 2)
                                    HStack{
                                        Text("Extra shot")
                                            .foregroundColor(Color.primary)
                                            .fontWeight(.bold)
                                            .font(.title2)
                                        Spacer()
                                        
                                        Button{
                                            addOne()
                                        }label: {
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(Color.primary)
                                        }
                                        
                                        Text("\(extraShots)")
                                            .onChange(of: extraShots) { newValue in
                                                TotalPricePerItem()
                                            }
                                        
                                        Button{
                                            subtractOne()
                                        }label: {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(Color.primary)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                }
                            }
                            
                            HStack{
                                Text("Item price: ")
                                    .fontWeight(.light)
                                    .padding(.leading)
                                    .foregroundColor(Color.primary)
                                    .font(.title2)
                                    
                                Spacer()
                                Text("\(finalDrinkPrice2)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.trailing)
                            }
                            .padding(.top, 25)
                            
                            VStack{
                                Text(successAlert)
                                    .foregroundColor(Color.green)
                            }
                            .padding(.top)
                            // Button for the drink
                            Button{
                                addToTheFirebaseOrder(drinkPicture: item.DrinkImageName, drinkName: item.DrinkName, drinkSize: selection, drinkCondition: selection2, drinkExtraShots: extraShots, drinkPrice: Double(finalDrinkPrice2) ?? 0.00)
                            }label: {
                                Text("Add to order")
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
                        }//MARK: END OF AN IF STATMENT
                        
                        
                        
                        //MARK: if the drink is not a coffee
                        if item.DrinkCanBeIced == false && item.ItemIsNotDrink == false && item.DrinkName != "Steamer" && item.DrinkName != "Latte" && item.DrinkName != "Cappuchino" && item.DrinkName != "Hot Chocolate" && item.DrinkName != "Cappucchino" && item.DrinkName != "Caruso" && item.DrinkName != "SunriseInfusion"{
                            VStack{
                                //MARK: If this is coffee make a picker for the sizes
                                HStack{
                                    Text("Drink size")
                                        .foregroundColor(Color.primary)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                    Spacer()
                                    Text("Required")
                                        .foregroundColor(Color.red)
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .padding(.bottom)
                                
                                // MARK: Drink size picker Goes here
                                Picker(
                                    selection: $selection3,
                                    label: Text("Picker"),
                                    content:{
                                        ForEach(drinkSize3.indices){index in
                                            Text(drinkSize3[index])
                                                .tag(drinkSize3[index])
                                        }.onChange(of: selection3) { newValue in
                                            TotalPricePerItem()
                                        }
                                    }
                                )
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.horizontal)
                                .padding(.bottom)
                                
                                // Final Price
                                HStack{
                                    Text("Item price: ")
                                        .fontWeight(.light)
                                        .padding(.leading)
                                        .foregroundColor(Color.primary)
                                        .font(.title2)
                                        
                                    Spacer()
                                    Text("\(finalDrinkPrice2)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.trailing)
                                }
                                .padding(.top, 25)
                                
                                VStack{
                                    Text(successAlert)
                                        .foregroundColor(Color.green)
                                }
                                .padding(.top)
                                
                                Button{
                                    addToTheFirebaseOrder(drinkPicture: item.DrinkImageName, drinkName: item.DrinkName, drinkSize: selection3, drinkCondition: selection2, drinkExtraShots: extraShots, drinkPrice: Double(finalDrinkPrice2) ?? 0.00)
                                }label: {
                                    Text("Add to order")
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
                            }//MARK: END OF A VSTACK
                        }
                    }//MARK: END OF A VSTACK
                }//MARK: END OF A SCROOL VIEW
                
                //DRINK SIZE IS EMPYU ALERT
                .alert(isPresented: $notifyThatSizeisEmpty, content:{
                    Alert(title: Text("Missing information"), message: Text("Please provide the required information for your order!"), dismissButton: .destructive(Text("Ok")))
                })
            }//MARK: END OF A ZSTACK
            .edgesIgnoringSafeArea(.top)
        }//MARK: END OF A NAVIGATION VIEW
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            //MARK: THIS IS CHECKING IF A PHONE IS CONNECTED TO THE WIFI
            if monitor.isConnected == false {
                nowifiAlert.toggle()
            }
        }//MARK: END OF ONAPEARK
    }
    
    // These are shots for the drink
    func addOne(){
        if extraShots == 3{
            return
        }
        else{
            extraShots += 1
        }
    }
    // These are shots for the drink
    func subtractOne(){
        if extraShots == 0{
            return
        }else{
            extraShots -= 1
        }
    }
    
    
    func TotalPricePerItem(){
        // MARK: WHITE MOCHA
        if item.DrinkName == "White Mocha" && selection == "8 oz"{
            if extraShots == 1{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 3.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "White Mocha" && selection == "12 oz"{
            if extraShots == 1{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "White Mocha" && selection == "16 oz"{
            if extraShots == 1{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "White Mocha" && selection == "20 oz"{
            if extraShots == 1{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        //MARK: LATTE
        else if item.DrinkName == "Latte" && selection == "8 oz"{
            if extraShots == 1{
                drinkPrice = 3.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 3.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Latte" && selection == "12 oz"{
            if extraShots == 1{
                drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 3.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Latte" && selection == "16 oz"{
            if extraShots == 1{
                drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Latte" && selection == "20 oz"{
            if extraShots == 1{
                drinkPrice = 5.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        //MARK: AMERICANO
        else if item.DrinkName == "Americano" && selection == "8 oz"{
            drinkPrice = 2.50
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Americano" && selection == "12 oz"{
            drinkPrice = 3.00
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Americano" && selection == "16 oz"{
            drinkPrice = 3.50
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Americano" && selection == "20 oz"{
            drinkPrice = 4.00
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        //MARK: FRAPPE
        else if item.DrinkName == "Frappe" && selection3 == "12 oz"{
            drinkPrice = 4.75
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Frappe" && selection3 == "16 oz"{
            drinkPrice = 5.00
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Frappe" && selection3 == "20 oz"{
            drinkPrice = 5.25
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Tea" && selection == "8 oz"{
            drinkPrice = 2.00
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Tea" && selection == "12 oz"{
            drinkPrice = 2.25
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Tea" && selection == "16 oz"{
            drinkPrice = 2.50
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Tea" && selection == "20 oz"{
            drinkPrice = 2.75
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Vanilla Chai Tea" && selection == "8 oz"{
            if extraShots == 1{
                drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 3.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Vanilla Chai Tea" && selection == "12 oz"{
            if extraShots == 1{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Vanilla Chai Tea" && selection == "16 oz"{
            if extraShots == 1{
                drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.75
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Vanilla Chai Tea" && selection == "20 oz"{
            if extraShots == 1{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Hot Chocolate" && selection == "8 oz"{
                drinkPrice = 2.75
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Hot Chocolate" && selection == "12 oz"{
            drinkPrice = 3.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
            
        }
        else if item.DrinkName == "Hot Chocolate" && selection == "16 oz"{
            drinkPrice = 3.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Hot Chocolate" && selection == "20 oz"{
            drinkPrice = 3.50
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Milkshake" && selection3 == "12 oz"{
            drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Milkshake" && selection3 == "16 oz"{
            drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Milkshake" && selection3 == "20 oz"{
            drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Italian Soda" && selection3 == "12 oz"{
            drinkPrice = 3.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Italian Soda" && selection3 == "16 oz"{
            drinkPrice = 3.75
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Italian Soda" && selection3 == "20 oz"{
            drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Steamer" && selection == "8 oz"{
            drinkPrice = 2.75
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Steamer" && selection == "12 oz"{
            drinkPrice = 3.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Steamer" && selection == "16 oz"{
            drinkPrice = 3.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Steamer" && selection == "20 oz"{
            drinkPrice = 3.50
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Smoothie" && selection3 == "12 oz"{
            drinkPrice = 3.75
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Smoothie" && selection3 == "16 oz"{
            drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Smoothie" && selection3 == "20 oz"{
            drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Bagels's w/ cream cheese"{
            drinkPrice = 2.50
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Muffin"{
            drinkPrice = 2.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Coconut Delight" && selection == "8 oz"{
            if extraShots == 1{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 3.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Coconut Delight" && selection == "12 oz"{
            if extraShots == 1{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Coconut Delight" && selection == "16 oz"{
            if extraShots == 1{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Coconut Delight" && selection == "20 oz"{
            if extraShots == 1{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "London Fog" && selection == "8 oz"{
            drinkPrice = 3.75
            let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "London Fog" && selection == "12 oz"{
            drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "London Fog" && selection == "16 oz"{
            drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "London Fog" && selection == "20 oz"{
            drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Caramel Macchiato" && selection == "8 oz"{
            if extraShots == 1{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 3.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Caramel Macchiato" && selection == "12 oz"{
            if extraShots == 1{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Caramel Macchiato" && selection == "16 oz"{
            if extraShots == 1{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Caramel Macchiato" && selection == "20 oz"{
            if extraShots == 1{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Cappucchino" && selection == "8 oz"{
            drinkPrice = 3.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Cappucchino" && selection == "12 oz"{
            drinkPrice = 3.75
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Cappucchino" && selection == "16 oz"{
            drinkPrice = 4.25
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Cappucchino" && selection == "20 oz"{
            drinkPrice = 4.75
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Caruso"{
            drinkPrice = 3.30
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Mocha" && selection == "8 oz"{
            if extraShots == 1{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 3.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Mocha" && selection == "12 oz"{
            if extraShots == 1{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Mocha" && selection == "16 oz"{
            if extraShots == 1{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 4.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Mocha" && selection == "20 oz"{
            if extraShots == 1{
                drinkPrice = 5.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 2{
                drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
            else if extraShots == 3{
                drinkPrice = 6.50
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }else{
                drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
            }
        }
        else if item.DrinkName == "Sunriseinfusion"{
            drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Macha Green Tea" && selection == "8 oz"{
            drinkPrice = 3.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Macha Green Tea" && selection == "12 oz"{
            drinkPrice = 4.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Macha Green Tea" && selection == "16 oz"{
            drinkPrice = 5.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Macha Green Tea" && selection == "20 oz"{
            drinkPrice = 6.00
                let doubleStr = String(format: "%.2f", drinkPrice)
            finalDrinkPrice2 = doubleStr
        }
        else if item.DrinkName == "Macarons"{
            drinkPrice = 1.60
                let doubleStr = String(format: "%.2f", drinkPrice)
                finalDrinkPrice2 = doubleStr
        }
    }
    
    
    
    func addToTheFirebaseOrder(drinkPicture: String ,drinkName: String, drinkSize: String, drinkCondition: String, drinkExtraShots: Int, drinkPrice: Double){
        if selection == "" && selection3 == ""{
            notifyThatSizeisEmpty.toggle()
        }
        else if item.DrinkCanBeIced == true && selection2 == ""{
            notifyThatSizeisEmpty.toggle()
        }
        else{
            let db = Firestore.firestore()
            db.collection("\(Auth.auth().currentUser?.uid as? String ?? "")").document().setData([
                "drinkPicture": drinkPicture,
                "drinkName": drinkName,
                "drinkSize": drinkSize,
                "drinkCondition": drinkCondition,
                "drinkExtraShot": drinkExtraShots,
                "drinkPrice": drinkPrice
            ])
            successAlert = "Your item was successully added to your cart."
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                successAlert = " "
            }
        }
    }
}

struct OrderDetailsMoreView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsMoreView(item: DrinkList.drinkData[1], drinkPrice: 0.00, exTraShotPrice: 0.50)
    }
}
