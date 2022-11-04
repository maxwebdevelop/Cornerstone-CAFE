//
//  MenueModule.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/12/22.
//

import SwiftUI

struct OneDrink: Identifiable {
    var id = UUID()
    var DrinkImageName: String
    var DrinkName: String
    var DrinkDescription: String
    var DrinkIsCoffee: Bool
    var ItemIsNotDrink : Bool
    var DrinkCanBeIced: Bool
    var coldDrink: Bool
    var drinkNumber: Int
    var isAvailable: Bool
}


struct DrinkList {
    
    static var drinkData = [
        OneDrink(DrinkImageName: "WhiteMocha", DrinkName: "White Mocha", DrinkDescription: "White chocolate version of a classic mocha", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: false, drinkNumber: 1, isAvailable: true),
        OneDrink(DrinkImageName: "Latte", DrinkName: "Latte", DrinkDescription: "Coffee drink made with espresso and steamed milk", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: false, drinkNumber: 2, isAvailable: true),
        OneDrink(DrinkImageName: "Americano", DrinkName: "Americano", DrinkDescription: "Coffee prepared by adding hot water to an espresso", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: false, drinkNumber: 3, isAvailable: true),
    OneDrink(DrinkImageName: "Frappe", DrinkName: "Frappe", DrinkDescription: "It consists of coffee or crème base, blended with ice and ingredients such as flavored syrups and usually topped with whipped cream and or spices. ", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: true, drinkNumber: 4, isAvailable: true),
    OneDrink(DrinkImageName: "Tea", DrinkName: "Tea", DrinkDescription: "", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: true, drinkNumber: 5, isAvailable: true),
    OneDrink(DrinkImageName: "VanillaChaiTea", DrinkName: "Vanilla Chai Tea", DrinkDescription: "Tea is blended with powdered vanilla creamer for a rich, smooth taste", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: true, drinkNumber: 6, isAvailable: true),
    OneDrink(DrinkImageName: "HotChocolate", DrinkName: "Hot Chocolate", DrinkDescription: "Hot chocolate starts in powder form (usually a blend of cocoa powder, sugar, and often includes dairy powder and flavorings or spices) and is typically made with water.", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: false, drinkNumber: 7, isAvailable: true),
    OneDrink(DrinkImageName: "Milkshake", DrinkName: "Milkshake", DrinkDescription: "A milkshake is a sweet beverage made by blending milk, ice cream, and flavorings or sweeteners such as butterscotch, caramel sauce, chocolate syrup, fruit syrup, or whole fruit into a thick, sweet, cold mixture.",  DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: true, drinkNumber: 8, isAvailable: true),
    OneDrink(DrinkImageName: "ItalianSoda", DrinkName: "Italian Soda", DrinkDescription: "An Italian soda is a soft drink made from carbonated water and flavored syrup.", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: true, drinkNumber: 9, isAvailable: true),
    OneDrink(DrinkImageName: "Steamer", DrinkName: "Steamer", DrinkDescription: "Warm milk with vanilla syrup topped with frothed milk", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: false, drinkNumber: 10, isAvailable: true),
    OneDrink(DrinkImageName: "Smoothie", DrinkName: "Smoothie", DrinkDescription: "A smoothie is a thick blended beverage with shake like consistency, normally pureed in a blender containing fruits and/or vegetables as well as an added liquid such as fruit juice, vegetable juice, milk, or even yogurt.", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: true, drinkNumber: 11, isAvailable: true),
    OneDrink(DrinkImageName: "Bagels", DrinkName: "Begels's w/ cream cheese", DrinkDescription: "", DrinkIsCoffee: false, ItemIsNotDrink: true, DrinkCanBeIced: false, coldDrink: false, drinkNumber: 12, isAvailable: true),
    OneDrink(DrinkImageName: "Muffin", DrinkName: "Muffin", DrinkDescription: "", DrinkIsCoffee: false, ItemIsNotDrink: true, DrinkCanBeIced: false, coldDrink: false, drinkNumber: 13, isAvailable: false),
    OneDrink(DrinkImageName: "CoconutDelight", DrinkName: "Coconut Delight", DrinkDescription: "", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: true, drinkNumber: 15, isAvailable: true),
    OneDrink(DrinkImageName: "LondonFog", DrinkName: "London Fog", DrinkDescription: " London Fog lattes are made by combining sweetened earl grey tea with some steamed milk and vanilla syrup.", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: false, drinkNumber: 16, isAvailable: true),
    OneDrink(DrinkImageName: "CaramelMachiato", DrinkName: "Caramel Macchiato", DrinkDescription: "A Caramel Macchiato is a coffee beverage with steamed milk, espresso, vanilla syrup and caramel drizzle. ", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: false, drinkNumber: 17, isAvailable: true),
    OneDrink(DrinkImageName: "Cappucchino", DrinkName: "Cappucchino", DrinkDescription: "", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: false, drinkNumber: 18, isAvailable: true),
   OneDrink(DrinkImageName: "Caruso", DrinkName: "Caruso", DrinkDescription: "", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: false, drinkNumber: 19, isAvailable: true),
    OneDrink(DrinkImageName: "Mocha", DrinkName: "Mocha", DrinkDescription: "Mocha is made up of one third epsresso and two thirds steamed milk with cocoa powder added", DrinkIsCoffee: true, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: false, drinkNumber: 20, isAvailable: true),
    OneDrink(DrinkImageName: "SunriseInfussion", DrinkName: "SunriseInfusion", DrinkDescription: "SunriseInfusion includes dried blueberries, blood orange, chamomile, and lavender.", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: false, coldDrink: true, drinkNumber: 21, isAvailable: true),
    OneDrink(DrinkImageName: "MotchaGreenTea", DrinkName: "Matcha Green Tea", DrinkDescription: "Processed green tea leaves that have been stone-ground into a delicate powder.", DrinkIsCoffee: false, ItemIsNotDrink: false, DrinkCanBeIced: true, coldDrink: false, drinkNumber: 22, isAvailable: true),
    OneDrink(DrinkImageName: "Macarons", DrinkName: "Macarons", DrinkDescription: "A macaroon is a small cake or biscuit, typically made from ground almonds, coconut or other nuts, with sugar and sometimes flavourings, and includes food colouring. ", DrinkIsCoffee: false, ItemIsNotDrink: true, DrinkCanBeIced: false, coldDrink: false, drinkNumber: 23, isAvailable: false)
   ]
}
