//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Md. Masud Rana on 1/24/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
