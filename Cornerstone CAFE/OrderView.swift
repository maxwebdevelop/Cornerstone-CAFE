//
//  OrderView.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/11/22.
//

import SwiftUI

struct OrderView: View {
    var items: [OneDrink] = DrinkList.drinkData
    @ObservedObject var monitor = NetworkConnection()
    @State private var nowifiAlert = false
    @State private var searchText = " "
    var body: some View {
        NavigationView{
            VStack{
            List(items, id: \.id){ item in
                NavigationLink(destination: OrderDetailsMoreView(item: item, drinkPrice: 0.00, exTraShotPrice: 0.50), label: {
                    ItemCell(item: item)
                    })
                }
                .alert(isPresented: $nowifiAlert){
                    Alert(title: Text("NO WIFI"), message: Text("Please connect your device to wifi."), dismissButton:
                            .destructive(Text("OK")))
                }
            }
                .navigationTitle("Menu")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
                if monitor.isConnected == false {
                    nowifiAlert.toggle()
                }
            }
        }
    }

struct ItemCell : View{
    var item : OneDrink
    var body: some View{
        HStack{
            Image(item.DrinkImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5){
                Text(item.DrinkName)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                Text(item.DrinkDescription)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
