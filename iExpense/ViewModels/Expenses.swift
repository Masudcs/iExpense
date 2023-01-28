//
//  Expenses.swift
//  iExpense
//
//  Created by Md. Masud Rana on 1/24/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()

            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let saveditems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: saveditems) {
                items = decodedItems
                return
            }

            items = []
        }
    }
    
    var personalItems: [ExpenseItem] {
        items.filter{$0.type == "Personal"}
    }
    
    var businessItems: [ExpenseItem] {
        items.filter{$0.type == "Business"}
    }
}
