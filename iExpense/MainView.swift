//
//  ContentView.swift
//  iExpense
//
//  Created by @andreev2k on 08.09.2022.
//

import SwiftUI

struct MainView: View {
    // экземпляр "класса расходов"
    @StateObject var expenses = Expenses()
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { section in
                    Section(header: Text(section.type).foregroundColor(colorType(for: section.type))) {
                        ForEach(section.itemses) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "RUB")).foregroundColor(colorAmount(for: Int(item.amount)))
                            }
                        }
                    }
                } .onDelete(perform: removeItem)
            }
            .listStyle(.inset)
            .navigationTitle("Мои расходы")
            .toolbar {
                EditButton()
                Button {
                    showAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    // метод для удаления элементов из списка
    func removeItem(offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
    // цвет amount
    func colorAmount(for amount: Int) -> Color {
        switch amount {
        case Int.min..<150 :
            return .green
        case 150..<500:
            return .orange
        default:
            return .red
        }
    }
    
    func colorType(for type: String) -> Color {
        switch type {
        case "Личные":
            return .teal
        case "Развлечения":
            return .purple
        default:
            return .indigo
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
