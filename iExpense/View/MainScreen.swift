//
//  ContentView.swift
//  iExpense
//
//  Created by Md. Masud Rana on 1/23/23.
//

import SwiftUI

struct MainScreen: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var expenseTypes = ["All", "Personal", "Business"]
    @State private var expenseType = "All"
    
    var expenseTypeData: [ExpenseItem] {
        switch expenseType {
        case "All":
            return expenses.items
        case "Personal":
            return expenses.personalItems
        default:
            return expenses.businessItems
        }
    }
    
    
    var body: some View {
        NavigationView {
            List {
                Picker("", selection: $expenseType) {
                    ForEach(expenseTypes, id:\.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                
                ForEach(expenseTypeData) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .expenseStyle(for: ExpenseItem(name: item.name, type: item.type, amount: item.amount))
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                   showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpenseStyle: ViewModifier {
    let expenseItem: ExpenseItem
    
    func body(content: Content) -> some View {
        switch expenseItem.amount {
        case 0..<10:
            content
                .foregroundColor(.green)
        case 10..<100:
            content
                .foregroundColor(.blue)
        default:
            content
                .font(.headline)
                .foregroundColor(.red)
        }
    }
}

extension View {
    func expenseStyle(for expenseItem: ExpenseItem) -> some View {
        modifier(ExpenseStyle(expenseItem: expenseItem))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

