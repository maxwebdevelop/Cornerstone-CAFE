//
//  CartDrinkViewModuel.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/17/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

struct Drink: Identifiable {
    var id: String
    var drinkName: String
    var drinkPicture: String
    var drinkSize: String
    var drinkCondition: String
    var drinkExtraShot: Int
    var drinkCost: Double
}

struct DrinkPrice: Identifiable {
    var id: String
    var DrinksCost: String
}


class CartDrinkViewModuel: ObservableObject {
    @Published var drinks = [Drink]()
    @Published var drinksw = [DrinkPrice]()
    
    func fetchDrinks(){
        let db = Firestore.firestore()
        
        db.collection("\(Auth.auth().currentUser?.uid as? String ?? "")").getDocuments{snapshot, error in
            if let error = error {
                return print("Error fetching the data from the firestore: \(error.localizedDescription)")
            } else {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.drinks = snapshot.documents.map { d in
                            return Drink(id: d.documentID, drinkName: d["drinkName"] as? String ?? "" , drinkPicture: d["drinkPicture"] as? String ?? "", drinkSize: d["drinkSize"] as? String ?? "", drinkCondition: d["drinkCondition"] as? String ?? "", drinkExtraShot: d["drinkExtraShot"] as? Int ?? 0, drinkCost: d["drinkPrice"] as? Double ?? 0.00)
                        }
                    }
                }
            }
        }
    }
    
    
    func deleteDate(drinkToDelete: Drink){
        let db = Firestore.firestore()
        
        db.collection("\(Auth.auth().currentUser?.uid as? String ?? "")").document(drinkToDelete.id).delete() { error in
            if error != nil {
                print("ERRROR", error!.localizedDescription)
            }else{
                DispatchQueue.main.async{
                    self.drinks.removeAll { drink in
                        return drink.id == drinkToDelete.id
                    }
                }
            }
        }
    }
    
    func addAllData(){
        
    }
}
