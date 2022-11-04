//
//  ItemDecor.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/17/22.
//

import SwiftUI

struct ItemDecor: View {
    var drink: Drink
    var body: some View {
        VStack{
            HStack{
                Image(drink.drinkPicture)
                    .resizable()
                    .frame(width: 65, height: 65, alignment: .leading)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .padding(.vertical)
                
                VStack{
                    Text(drink.drinkName)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .font(.title2)
                        .padding(.bottom)
                    HStack{
                        Spacer()
                        HStack{
                            Text("Drink size:")
                                .foregroundColor(Color.secondary)
                            Text(drink.drinkSize)
                        }
                        Spacer()
                        HStack{
                            Text("Extra shot:")
                                .foregroundColor(Color.secondary)
                            Text(" \(drink.drinkExtraShot)")
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ItemDecor_Previews: PreviewProvider {
    static var previews: some View {
        let drink = Drink(id: "Adfwer4@$", drinkName: "Caramel Machiato", drinkPicture: "CaramelMachiato", drinkSize: "Small", drinkCondition: "Iced", drinkExtraShot: 1, drinkCost: 00)
        ItemDecor(drink: drink)
    }
}
